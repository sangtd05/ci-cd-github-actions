# GitHub Actions CI/CD Pipeline

## 🚀 Tính năng

- ✅ GitHub Actions CI/CD Pipeline
- ✅ Docker containerization
- ✅ Multi-platform builds (AMD64, ARM64)
- ✅ Kubernetes deployment
- ✅ Health checks và monitoring
- ✅ SSL/TLS với Let's Encrypt
- ✅ Security best practices

## 📋 Yêu cầu

- GitHub repository
- Docker Hub account
- Kubernetes cluster
- kubectl configured

## 🛠️ Thiết lập

### 1. Cấu hình GitHub Secrets

Thêm các secrets sau vào GitHub repository:

```
DOCKER_USERNAME=your-dockerhub-username
DOCKER_PASSWORD=your-dockerhub-password
KUBE_CONFIG=base64-encoded-kubeconfig
```

### 2. Cấu hình Docker Hub

1. Tạo tài khoản Docker Hub
2. Tạo repository mới
3. Cập nhật `IMAGE_NAME` trong workflow nếu cần

### 3. Cấu hình Kubernetes

1. Tạo kubeconfig cho cluster
2. Encode base64: `cat ~/.kube/config | base64 -w 0`
3. Thêm vào GitHub Secrets

### 4. Cập nhật cấu hình

#### Dockerfile
- Cập nhật base image nếu cần
- Thay đổi port nếu ứng dụng sử dụng port khác

#### Kubernetes Manifests
- Cập nhật domain trong `k8s/ingress.yaml`
- Cập nhật image name trong `k8s/deployment.yaml`
- Cấu hình secrets trong `k8s/secret.yaml`

## 📁 Cấu trúc dự án

```
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # GitHub Actions workflow
├── k8s/
│   ├── namespace.yaml         # Kubernetes namespace
│   ├── configmap.yaml         # Configuration
│   ├── secret.yaml           # Secrets
│   ├── deployment.yaml       # Application deployment
│   ├── service.yaml          # Service
│   └── ingress.yaml          # Ingress với SSL
├── Dockerfile                # Docker image
├── package.json              # Node.js dependencies
├── index.js                  # Main application
└── README.md                 # Documentation
```

## 🔄 Workflow

1. **Push code** → Trigger GitHub Actions
2. **Test** → Run tests và linting
3. **Build** → Build Docker image multi-platform
4. **Push** → Push image lên Docker Hub
5. **Deploy** → Deploy lên Kubernetes cluster

## 🐳 Docker

### Build locally
```bash
docker build -t github-action-app .
```

### Run locally
```bash
docker run -p 3000:3000 github-action-app
```

## ☸️ Kubernetes

### Deploy manually
```bash
kubectl apply -f k8s/
```

### Check deployment
```bash
kubectl get pods -n github-action-app
kubectl get services -n github-action-app
kubectl get ingress -n github-action-app
```

## 🔧 Development

### Install dependencies
```bash
npm install
```

### Run development server
```bash
npm run dev
```

### Run tests
```bash
npm test
```

### Lint code
```bash
npm run lint
```

## 📊 Monitoring

- Health check endpoint: `/health`
- Application status: `/api/status`

## 🔒 Security

- Non-root user trong Docker container
- Security headers với Helmet
- Secrets management trong Kubernetes
- SSL/TLS với Let's Encrypt

## 🚨 Troubleshooting

### Common issues

1. **Docker build fails**
   - Kiểm tra Dockerfile syntax
   - Verify package.json dependencies

2. **Kubernetes deployment fails**
   - Check kubeconfig
   - Verify image exists trên Docker Hub
   - Check resource limits

3. **Ingress không hoạt động**
   - Verify domain configuration
   - Check cert-manager installation
   - Verify nginx-ingress controller