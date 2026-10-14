# Terraform Remote State

A small Terraform project demonstrating remote state management using an S3-compatible backend on LocalStack.

The project separates backend bootstrapping from infrastructure provisioning and shows how Terraform state can be stored remotely instead of in a local `terraform.tfstate` file.

## Features

- Remote Terraform state with S3 backend
- Native state locking with `use_lockfile`
- S3 versioning for state recovery
- Separate bootstrap and infrastructure configurations
- Local AWS service emulation with LocalStack
- No real AWS account required

## Architecture

```text
Terraform
   |
   v
LocalStack S3
   |
   +-- terraform-remote-state
   |      |
   |      +-- infrastructure/
   |             |
   |             +-- terraform.tfstate
   |
   +-- terraform-remote-state-demo
```

The `terraform-remote-state` bucket stores the Terraform state, while `terraform-remote-state-demo` is a simple example resource managed by Terraform.

## Project Structure

```text
terraform-remote-state/
│
├── bootstrap/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── infrastructure/
│   ├── backend.tf
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── docker-compose.yml
├── .gitignore
└── README.md
```

## How It Works

The project is split into two Terraform configurations.

### Bootstrap

The `bootstrap/` configuration creates the S3 bucket used as the remote Terraform backend and enables versioning.

### Infrastructure

The `infrastructure/` configuration uses the previously created S3 bucket as its backend and stores its state at:

```text
s3://terraform-remote-state/infrastructure/terraform.tfstate
```

It also creates a demo S3 bucket to verify that the remote state setup works correctly.

## Requirements

- Terraform 1.10+
- Docker
- Docker Compose
- AWS CLI

## Usage

Start LocalStack:

```bash
docker compose up -d
```

Create the remote state bucket:

```bash
cd bootstrap

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Then initialize and deploy the example infrastructure:

```bash
cd ../infrastructure

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Verification

List the LocalStack S3 buckets:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

Expected buckets:

```text
terraform-remote-state
terraform-remote-state-demo
```

Verify that the Terraform state is stored remotely:

```bash
aws --endpoint-url=http://localhost:4566 \
  s3 ls s3://terraform-remote-state/infrastructure/
```

Expected result:

```text
terraform.tfstate
```

The `infrastructure/` directory should not contain a local `terraform.tfstate` file.

## LocalStack Version

This project uses:

```text
localstack/localstack:4.14.0
```

The version is intentionally pinned to use the legacy Community image without requiring an authentication token.

## Cleanup

Destroy the demo infrastructure first:

```bash
cd infrastructure
terraform destroy
```

Then destroy the backend infrastructure:

```bash
cd ../bootstrap
terraform destroy
```

Finally, stop LocalStack:

```bash
cd ..
docker compose down
```

## Key Takeaways

This project helped me strengthen my practical understanding of:

- configuring Terraform with a remote S3-compatible backend
- separating backend bootstrapping from infrastructure provisioning
- managing Terraform state outside the local filesystem
- using native S3 state locking for safer concurrent operations
- enabling versioning for state recovery
- working with LocalStack for local AWS-compatible infrastructure testing
- verifying remote state behavior with the AWS CLI
