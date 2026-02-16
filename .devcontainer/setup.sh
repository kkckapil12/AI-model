
#!/bin/bash
set -e

echo "🔧 Updating system..."
sudo apt-get update -y

echo "📦 Installing base packages..."
sudo apt-get install -y \
    curl wget git unzip jq yq \
    software-properties-common gnupg lsb-release \
    python3 python3-pip ansible

############################################
# TERRAFORM
############################################
echo "🌍 Installing Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y terraform

############################################
# KUBECTL
############################################
echo "☸️ Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

############################################
# HELM
############################################
echo "⛵ Installing Helm..."
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sudo chmod +x /usr/local/bin/helm


############################################
# AWS CLI
############################################
echo "☁️ Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

############################################
# GOOGLE CLOUD CLI
############################################
echo "🌐 Installing gcloud..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

sudo apt-get update && sudo apt-get install -y google-cloud-cli

############################################
# DOCKER CLI
############################################
echo "🐳 Installing Docker CLI..."
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER

############################################
# CLEANUP
############################################
echo "🧹 Cleaning..."
sudo apt-get autoremove -y

############################################
# VERSIONS
############################################
echo "================ Versions ================"
terraform -version
kubectl version --client
helm version
aws --version
gcloud --version
ansible --version
python3 --version
docker --version
echo "=========================================="

