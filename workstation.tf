resource "aws_key_pair" "key" {
  key_name = "secret_key"
  public_key =file("E:/DevopsAws/secret_key.pub") #Make sure you already created a key pair file if not,create with your custom name and paste the file location where you have created
  
}

#creating the Security Group 
resource "aws_security_group" "allow_ssh" {
  name ="allow_ssh"
  description = "Allow SSH and HTTP inbound traffic"
  ingress{
   from_port ="22"
   to_port = "22"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
    ingress{
   from_port ="80"
   to_port = "80"
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

    egress{
   from_port ="0"
   to_port = "0"
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "allow_ssh"
  }
}

resource "aws_instance" "workstation" {
  ami= data.aws_ami.ubuntu.id
  instance_type ="t3.medium"
  key_name = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  user_data= file("work.sh") #Installing the realted tools.
  tags = {
    Name ="workstationForCluster"
  }
}
