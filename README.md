# Tofu Controller App

A modern Node.js application that demonstrates infrastructure-as-code using Terraform, containerized with Docker, and deployed via Helm charts with embedded cluster support.

## 🏗️ Architecture

This project consists of several components working together:

- **Node.js Application**: Express.js app connecting to PostgreSQL
- **Terraform Infrastructure**: AWS VPC, RDS PostgreSQL, and security groups
- **Helm Charts**: Kubernetes deployment configuration
- **Embedded Cluster**: Pre-configured Kubernetes cluster with Flux and Tofu Controller

## 📁 Project Structure

```
tofu-controller-app/
├── infrastructure/           # Terraform configuration
│   ├── main.tf              # AWS resources (VPC, RDS, Security Groups)
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values
│   ├── versions.tf          # Version constraints
│   └── README.md            # Infrastructure documentation
├── node/                    # Node.js application
│   ├── index.js             # Express server with PostgreSQL connection
│   ├── package.json         # Node.js dependencies
│   └── Dockerfile           # Container configuration
├── chart/                   # Helm chart
│   └── tofu-controller-app/
│       ├── Chart.yaml       # Chart metadata
│       ├── values.yaml      # Default configuration values
│       └── templates/       # Kubernetes manifests
└── replicated/              # Embedded cluster configuration
    ├── application.yaml     # Application metadata
    ├── config.yaml          # Configuration schema
    └── embeddedcluster.yaml # Embedded cluster configuration
```

## 🚀 Quick Start

### Prerequisites

- Node.js 16+ and npm
- Docker
- kubectl
- Helm 3.x
- AWS CLI configured
- Terraform 1.0+

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tofu-controller-app
   ```

2. **Install Node.js dependencies**
   ```bash
   cd node
   npm install
   ```

3. **Set up environment variables**
   ```bash
   export DB_HOST=your-postgres-host
   export DB_PORT=5432
   export DB_USER=your-username
   export DB_PASSWORD=your-password
   export DB_NAME=your-database
   ```

4. **Run the application locally**
   ```bash
   npm start
   ```

   The app will be available at `http://localhost:3000`

### Docker Build

```bash
cd node
docker build -t tofu-controller-app .
docker run -p 3000:3000 --env-file .env tofu-controller-app
```

## 🏗️ Infrastructure Deployment

### Using Terraform Directly

1. **Navigate to infrastructure directory**
   ```bash
   cd infrastructure
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Create a terraform.tfvars file**
   ```hcl
   aws_region = "us-west-2"
   vpc_cidr = "10.0.0.0/16"
   private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
   db_instance_class = "db.t3.micro"
   db_allocated_storage = 20
   db_name = "myapp"
   db_username = "myuser"
   db_password = "your-secure-password"
   ```

4. **Deploy infrastructure**
   ```bash
   terraform plan
   terraform apply
   ```

### Using Helm Chart

1. **Install the Helm chart**
   ```bash
   cd chart
   helm install tofu-controller-app ./tofu-controller-app \
     --set aws.accessKeyId=YOUR_ACCESS_KEY \
     --set aws.secretAccessKey=YOUR_SECRET_KEY \
     --set aws.region=us-west-2 \
     --set db.name=myapp \
     --set db.user=myuser \
     --set db.password=your-password
   ```

2. **Check deployment status**
   ```bash
   kubectl get pods -l app=tofu-controller-app
   ```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Application port | `3000` |
| `DB_HOST` | PostgreSQL host | Required |
| `DB_PORT` | PostgreSQL port | `5432` |
| `DB_USER` | Database username | Required |
| `DB_PASSWORD` | Database password | Required |
| `DB_NAME` | Database name | Required |

### Helm Values

Key configuration options in `values.yaml`:

- **Image**: Container registry and tag
- **AWS**: Access keys and region for infrastructure
- **VPC**: Network configuration
- **Database**: PostgreSQL connection details
- **Terraform**: Git repository settings for infrastructure code

### Embedded Cluster Configuration

The embedded cluster includes:

- **Flux 2.16.0**: GitOps toolkit for Kubernetes
- **Tofu Controller 0.16.0-rc.5**: Terraform controller for Flux
- **Configuration**: 
  - `allowCrossNamespaceRefs: false`
  - `watchAllNamespaces: true`

## 🔍 Monitoring and Health Checks

The application includes basic health monitoring:

- **Health endpoint**: `GET /` - Returns database connection status
- **Database connectivity**: Automatic connection testing on startup
- **Error handling**: Graceful failure with detailed error messages

## 🛠️ Development

### Adding New Features

1. **Modify the Node.js application** in `node/index.js`
2. **Update dependencies** in `node/package.json`
3. **Rebuild the Docker image**
4. **Update the Helm chart** if needed
5. **Test locally** before deploying

### Infrastructure Changes

1. **Modify Terraform files** in `infrastructure/`
2. **Test with `terraform plan`**
3. **Update Helm templates** if needed

### Embedded Cluster Customization

To modify the embedded cluster configuration:

1. **Edit** `replicated/embeddedcluster.yaml`
2. **Update chart versions** or add new charts
3. **Configure chart values** as needed
4. **Test the configuration** in a development environment

## 🔒 Security Considerations

- **Database passwords**: Use secure, randomly generated passwords
- **AWS credentials**: Use IAM roles when possible, limit permissions
- **Network security**: RDS is deployed in private subnets with security groups
- **Secrets management**: Use Kubernetes secrets for sensitive data
- **Cross-namespace access**: Configure `allowCrossNamespaceRefs` appropriately

## 📝 API Reference

### Endpoints

- `GET /` - Health check and database time display

### Response Format

```json
{
  "message": "Hello! Postgres time is 2024-01-15T10:30:00.000Z"
}
```

## 🚀 Deployment Options

### Option 1: Traditional Kubernetes
- Deploy using Helm charts directly
- Manual infrastructure provisioning
- Full control over the deployment

### Option 2: Embedded Cluster
- Pre-configured Kubernetes cluster
- Flux and Tofu Controller pre-installed
- GitOps workflow ready

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

[Add your license information here]

## 🆘 Support

For issues and questions:

1. Check the [documentation](link-to-docs)
2. Search existing [issues](link-to-issues)
3. Create a new issue with detailed information

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Helm Documentation](https://helm.sh/docs)
- [Flux Documentation](https://fluxcd.io/docs)
- [Tofu Controller Documentation](https://github.com/opentofu/terraform-controller)

---

**Note**: This application is designed for demonstration and learning purposes. For production use, ensure proper security configurations and follow best practices for your specific environment. 