#!/bin/bash
# For ubuntu

# Update package lists and install Docker
sudo apt update -y
sudo apt-get update -y
sudo apt install docker.io -y
sudo apt install curl -y
sudo apt install wget -y
apt install gpg -y

# Disble swap on the system (k8s doesn't work with swap enabled)
sudo swapoff -a

# Set up Kubernetes repository and install kubelet, kubeadm, and kubectl
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get install -y kubelet kubeadm kubectl

# Enable net.bridge.bridge-nf-call-iptables
sudo sysctl net.bridge.bridge-nf-call-iptables=1

# Setting default container runtime socket endpoint for cri-docker 
echo "runtime-endpoint: unix:///var/run/cri-dockerd.sock" >> /etc/crictl.yaml

# Download and install cri-dockerd
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.14/cri-dockerd-0.3.14.amd64.tgz
tar -xvf cri-dockerd-0.3.14.amd64.tgz
cd cri-dockerd
sudo install -o root -g root -m 0755 cri-dockerd /usr/local/bin/cri-dockerd

# Download and set up cri-dockerd systemd service
cd ..
wget https://github.com/Mirantis/cri-dockerd/archive/refs/tags/v0.3.14.tar.gz
tar -xvf v0.3.14.tar.gz
cd cri-dockerd-0.3.14/
sudo cp packaging/systemd/* /etc/systemd/system
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

# Enable and start cri-docker service
sudo systemctl daemon-reload
sudo systemctl enable --now cri-docker.socket
sudo systemctl enable cri-docker
sudo systemctl start cri-docker

# Check status of installed services
kubectl --version
kubelet --version
kubectl --version
crictl --version
sudo crictl info
sudo systemctl status cri-docker
sudo systemctl status kubelet
