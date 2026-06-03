#!/bin/bash
# ============================================
# First-time setup for AWS EC2 (Ubuntu 22.04)
# Run this script ON the EC2 instance via SSH
# ============================================

echo "📦 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🐳 Installing Docker..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to docker group (no sudo needed for docker commands)
sudo usermod -aG docker $USER

echo "🔥 Configuring firewall..."
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw allow 8080/tcp  # API
sudo ufw --force enable

echo ""
echo "✅ EC2 setup complete!"
echo "⚠️  Log out and log back in for Docker group changes to take effect."
echo ""
echo "Next steps:"
echo "  1. Log out: exit"
echo "  2. Log back in: ssh -i your-key.pem ubuntu@your-ec2-ip"
echo "  3. Run deploy script from your local machine: bash deploy-ec2.sh"
