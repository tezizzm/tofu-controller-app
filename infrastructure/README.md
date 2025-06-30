# Infrastructure as Code

This directory contains the Terraform configuration for provisioning AWS infrastructure for the Tofu Controller App.

## 🏗️ Infrastructure Components

The Terraform configuration creates the following AWS resources:

- **VPC**: Virtual Private Cloud with custom CIDR block
- **Private Subnets**: Two private subnets across different availability zones
- **Security Groups**: Database security group allowing PostgreSQL access
- **RDS Subnet Group**: Database subnet group for RDS placement
- **RDS PostgreSQL Instance**: Managed PostgreSQL database

## 📁 Files

- `main.tf` - Main Terraform configuration with AWS resources
- `variables.tf` - Input variables and their definitions
- `outputs.tf` - Output values from the infrastructure
- `versions.tf` - Terraform and provider version constraints

## 🚀 Usage

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform 1.0+ installed
- AWS provider access

### Deployment

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Create terraform.tfvars file**
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

3. **Plan the deployment**
   ```bash
   terraform plan
   ```

4. **Apply the configuration**
   ```bash
   terraform apply
   ```

### Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `aws_region` | AWS region to deploy resources | `string` | `"us-west-2"` |
| `vpc_cidr` | CIDR block for the VPC | `string` | `"10.0.0.0/16"` |
| `private_subnets` | List of private subnet CIDRs | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` |
| `db_instance_class` | RDS instance class | `string` | `"db.t3.micro"` |
| `db_allocated_storage` | RDS allocated storage in GB | `number` | `20` |
| `db_name` | Initial database name | `string` | Required |
| `db_username` | Master username for RDS | `string` | Required |
| `db_password` | Master password for RDS | `string` | Required |

### Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | ID of the created VPC |
| `private_subnet_ids` | IDs of the private subnets |
| `db_endpoint` | RDS instance endpoint |
| `db_port` | RDS instance port |

## 🔒 Security

- RDS instance is deployed in private subnets
- Security group restricts access to PostgreSQL port (5432)
- Database is not publicly accessible
- Use strong passwords and consider using AWS Secrets Manager

## 🧹 Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

**Warning**: This will delete all created resources including the database and its data.

## 📝 Notes

- The infrastructure uses the AWS VPC module for consistent VPC creation
- RDS instance is configured with skip_final_snapshot for demo purposes
- Consider enabling backup and monitoring for production use
- Network ACLs and additional security groups may be needed for production 