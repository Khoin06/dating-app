#!/bin/bash
# ============================================
# Deploy Dating App Backend to AWS EC2
# ============================================
# Prerequisites:
#   - AWS EC2 instance (Ubuntu 22.04+ recommended)
#   - Docker installed on EC2
#   - Security Group allows port 80, 443, 8080
#   - SSH access to EC2
# ============================================

# === CONFIGURATION - CHANGE THESE VALUES ===
EC2_HOST="your-ec2-public-ip"
EC2_USER="ubuntu"
SSH_KEY="~/.ssh/your-key.pem"
APP_NAME="dating-app-api"
# ============================================

echo "🚀 Building Docker image..."
docker build -t $APP_NAME .

echo "📦 Saving Docker image..."
docker save $APP_NAME | gzip > ${APP_NAME}.tar.gz

echo "📤 Uploading to EC2..."
scp -i $SSH_KEY ${APP_NAME}.tar.gz $EC2_USER@$EC2_HOST:~/ 

echo "🔧 Deploying on EC2..."
ssh -i $SSH_KEY $EC2_USER@$EC2_HOST << 'DEPLOY_SCRIPT'
    # Load Docker image
    docker load < ~/dating-app-api.tar.gz

    # Stop existing container if running
    docker stop dating-app-api 2>/dev/null
    docker rm dating-app-api 2>/dev/null

    # Create data directory for SQLite persistence
    mkdir -p ~/dating-app-data

    # Run container
    docker run -d \
        --name dating-app-api \
        --restart unless-stopped \
        -p 8080:8080 \
        -v ~/dating-app-data:/app/data \
        -e ASPNETCORE_ENVIRONMENT=Production \
        -e TokenKey="CHANGE_THIS_TO_YOUR_SECRET_KEY_64_CHARS_MINIMUM_aaaaaaaaaaaaaaa" \
        dating-app-api

    echo "✅ Container started!"
    docker ps | grep dating-app-api

    # Clean up
    rm -f ~/dating-app-api.tar.gz
DEPLOY_SCRIPT

# Clean up local
rm -f ${APP_NAME}.tar.gz

echo ""
echo "✅ Deploy complete!"
echo "🌐 API available at: http://$EC2_HOST:8080"
echo ""
echo "⚠️  Don't forget to:"
echo "  1. Change TokenKey to a real secret"
echo "  2. Update CORS in Program.cs with your Vercel domain"
echo "  3. Update environment.prod.ts with http://$EC2_HOST:8080"
