#!/bin/bash
user=$(id -u) 

Red="\e[31m"
Green="\e[32m"
Normal="\e[0m"


if [ $user -ne 0 ]
then
echo " please run the script with the root user"
exit 1
else 
echo "you are the super user installation will be inprogress"
fi

validate()
if [ $1 -ne 0 ]
then
echo -e "Installation of $2 is $Red Failure.. $Normal"
#exit 1
else
echo -e "Installation of the $2 is $Green success..$Normal"
fi

# Install kubectl
apt update
apt install curl -y
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
validate $? "Kubectl"


# Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
 apt-get install unzip -y
unzip awscliv2.zip
 ./aws/install
validate $? "Aws CLI"

# eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
eksctl version
VALIDATE $? "eksctl installation"