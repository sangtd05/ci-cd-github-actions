#!/bin/bash

# GitHub Actions CI/CD Setup Script
echo "🚀 Setting up GitHub Actions CI/CD Pipeline..."

# Check if required tools are installed
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ $1 is not installed. Please install it first."
        exit 1
    else
        echo "✅ $1 is installed"
    fi
}

echo "📋 Checking required tools..."
check_tool "node"
check_tool "npm"
check_tool "docker"
check_tool "kubectl"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cat > .env << EOF
NODE_ENV=development
PORT=3000
LOG_LEVEL=info
EOF
    echo "✅ .env file created"
else
    echo "✅ .env file already exists"
fi

# Test the application
echo "🧪 Running tests..."
npm test

echo "🔍 Running linter..."
npm run lint

echo "🐳 Testing Docker build..."
docker build -t github-action-app:test .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful"
else
    echo "❌ Docker build failed"
    exit 1
fi

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Create a GitHub repository"
echo "2. Add the following secrets to your GitHub repository:"
echo "   - DOCKER_USERNAME: Your Docker Hub username"
echo "   - DOCKER_PASSWORD: Your Docker Hub password"
echo "   - KUBE_CONFIG: Base64 encoded kubeconfig"
echo ""
echo "3. Update the following files with your configuration:"
echo "   - k8s/ingress.yaml: Replace 'your-domain.com' with your actual domain"
echo "   - k8s/deployment.yaml: Update image name if needed"
echo "   - k8s/secret.yaml: Add your actual secrets"
echo ""
echo "4. Push your code to trigger the CI/CD pipeline"
echo ""
echo "🔗 Useful commands:"
echo "   npm run dev          # Start development server"
echo "   npm test            # Run tests"
echo "   npm run lint        # Run linter"
echo "   docker run -p 3000:3000 github-action-app:test  # Test Docker container"
