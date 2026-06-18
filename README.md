# Flask Web App Deployment on AWS EC2 using Terraform and Docker

## Overview

This project demonstrates how to deploy a simple Flask web application on an AWS EC2 instance using Infrastructure as Code (Terraform) and containerization (Docker). The infrastructure is provisioned automatically using Terraform, and the application runs inside a Docker container on the EC2 instance.

---

## Architecture

```text
Local Machine
   |
   |  (Terraform Apply)
   v
AWS EC2 Instance (Ubuntu)
   |
   |  (Docker Installation)
   v
Docker Container
   |
   v
Flask Web Application
   |
   v
Browser Access (Port 5000)
```

---

## Technologies Used

* AWS EC2 (Cloud Compute)
* Terraform (Infrastructure as Code)
* Docker (Containerization)
* Flask (Python Web Framework)
* Ubuntu 22.04 LTS

---

## Project Structure

```text
project/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── app/
│   ├── app.py
│   ├── Dockerfile
│
└── README.md
```

---

## Prerequisites

Before running this project, ensure the following are available:

* AWS account or AWS Learner Lab access
* Terraform installed locally
* AWS CLI configured if required
* SSH key pair created in AWS
* Basic understanding of Linux command line

---

## Deployment Steps

### 1. Initialize Terraform

```bash
cd terraform
terraform init
```

---

### 2. Deploy Infrastructure

```bash
terraform apply
```

Confirm with `yes` when prompted.

This will create:

* EC2 instance
* Security group
* Public IP address

---

### 3. Get Public IP

```bash
terraform output public_ip
```

---

### 4. SSH into EC2

```bash
ssh -i your-key.pem ubuntu@<public-ip>
```

---

### 5. Install Docker on EC2

```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

---

### 6. Upload Application Files

From local machine:

```bash
scp -r -i your-key.pem ../app ubuntu@<public-ip>:~
```

---

### 7. Build Docker Image

Inside EC2:

```bash
cd app
sudo docker build -t flask-app .
```

---

### 8. Run Docker Container

```bash
sudo docker run -d -p 5000:5000 flask-app
```

---

### 9. Access Application

Open in browser:

```text
http://<public-ip>:5000
```

You should see the Flask application running successfully.

---

## Cleanup

To destroy all AWS resources created by Terraform:

```bash
cd terraform
terraform destroy
```

Confirm with `yes`.

This ensures no unnecessary cloud resources remain active.

---

## Security Notes

* SSH access is restricted using Security Groups
* Port 5000 is exposed only for learning purposes
* In production environments, a reverse proxy (such as Nginx) should be used instead of exposing Flask directly
* Sensitive credentials should never be hardcoded in Terraform files

---

## Key Learnings

* Infrastructure as Code using Terraform
* Cloud deployment on AWS EC2
* Containerization using Docker
* Networking and security group configuration
* End-to-end deployment workflow for a web application
