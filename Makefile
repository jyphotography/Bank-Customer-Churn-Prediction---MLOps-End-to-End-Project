# Bank Customer Churn Prediction - MLOps Project Makefile

# Variables
PYTHON := python3.11
VENV := venv
VENV_BIN := $(VENV)/bin
PIP := $(VENV_BIN)/pip
PYTHON_VENV := $(VENV_BIN)/python
JUPYTER := $(VENV_BIN)/jupyter

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

.PHONY: help setup clean install-dev test lint format run-notebook run-lab check-env check-setup list-packages

# Default target
help:
	@echo "$(GREEN)Bank Customer Churn Prediction - MLOps Project$(NC)"
	@echo "$(YELLOW)Available commands:$(NC)"
	@echo "  setup          - Create virtual environment and install all dependencies"
	@echo "  clean          - Remove virtual environment and cache files"
	@echo "  install-dev    - Install development dependencies only"
	@echo "  test           - Run all tests"
	@echo "  lint           - Run linting checks (flake8, mypy)"
	@echo "  format         - Format code with black and isort"
	@echo "  run-notebook   - Start Jupyter Notebook server"
	@echo "  jupyter-safe   - Start Jupyter with environment verification"
	@echo "  run-lab        - Start JupyterLab server"
	@echo "  eda            - Start EDA notebook directly"
	@echo "  model-dev      - Start Model Development notebook"
	@echo "  model-dev-clean - Start CLEAN Model Development (no data leakage)"
	@echo "  test-fix       - Test model training fix"
	@echo "  check-env      - Verify virtual environment setup"
	@echo "  check-setup    - Comprehensive setup verification"
	@echo "  list-packages  - List all installed packages"

# Setup virtual environment and install dependencies
setup:
	@echo "$(GREEN)Setting up virtual environment...$(NC)"
	$(PYTHON) -m venv $(VENV)
	@echo "$(GREEN)Installing dependencies...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install --upgrade setuptools wheel
	$(PIP) install -r requirements.txt
	@echo "$(GREEN)Setting up pre-commit hooks...$(NC)"
	$(VENV_BIN)/pre-commit install
	@echo "$(GREEN)✅ Setup complete!$(NC)"
	@echo "$(YELLOW)To activate the environment, run:$(NC)"
	@echo "  source $(VENV)/bin/activate  # On macOS/Linux"
	@echo "  $(VENV)\\Scripts\\activate     # On Windows"

# Clean up virtual environment and cache files
clean:
	@echo "$(YELLOW)Cleaning up...$(NC)"
	rm -rf $(VENV)
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf *.egg-info
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	@echo "$(GREEN)✅ Cleanup complete!$(NC)"

# Install only development dependencies (minimal setup)
install-dev:
	@echo "$(GREEN)Installing development dependencies...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install pandas numpy matplotlib seaborn scipy plotly jupyter scikit-learn
	@echo "$(GREEN)✅ Development setup complete!$(NC)"

# Run tests
test:
	@echo "$(GREEN)Running tests...$(NC)"
	$(VENV_BIN)/pytest tests/ -v --cov=src --cov-report=term-missing

# Run linting checks
lint:
	@echo "$(GREEN)Running linting checks...$(NC)"
	$(VENV_BIN)/flake8 src/ tests/
	$(VENV_BIN)/mypy src/

# Format code
format:
	@echo "$(GREEN)Formatting code...$(NC)"
	$(VENV_BIN)/black src/ tests/
	$(VENV_BIN)/isort src/ tests/

# Start Jupyter Notebook
run-notebook:
	@echo "$(GREEN)Starting Jupyter Notebook...$(NC)"
	@echo "$(YELLOW)Notebook will open at: http://localhost:8888$(NC)"
	$(JUPYTER) notebook

# Start Jupyter with environment verification
jupyter-safe:
	@echo "$(GREEN)Starting Jupyter with environment verification...$(NC)"
	./start_jupyter.sh

# Start JupyterLab
run-lab:
	@echo "$(GREEN)Starting JupyterLab...$(NC)"
	@echo "$(YELLOW)JupyterLab will open at: http://localhost:8888$(NC)"
	$(VENV_BIN)/jupyter lab

# Check virtual environment
check-env:
	@echo "$(GREEN)Checking virtual environment...$(NC)"
	@if [ -d "$(VENV)" ]; then \
		echo "$(GREEN)✅ Virtual environment exists$(NC)"; \
		echo "$(YELLOW)Python version:$(NC)"; \
		$(PYTHON_VENV) --version; \
		echo "$(YELLOW)Pip version:$(NC)"; \
		$(PIP) --version; \
		echo "$(YELLOW)Key packages:$(NC)"; \
		$(PIP) show pandas numpy matplotlib jupyter scikit-learn | grep "Version"; \
	else \
		echo "$(RED)❌ Virtual environment not found. Run 'make setup'$(NC)"; \
	fi

# Comprehensive setup verification
check-setup:
	@echo "$(GREEN)Running comprehensive setup verification...$(NC)"
	$(PYTHON_VENV) check_setup.py

# List all installed packages
list-packages:
	@echo "$(GREEN)Installed packages:$(NC)"
	$(PIP) list

# Quick start for EDA
eda:
	@echo "$(GREEN)Starting EDA notebook...$(NC)"
	$(JUPYTER) notebook 01_exploratory_data_analysis.ipynb

# Model development notebook (original)
model-dev:
	@echo "$(GREEN)Starting Model Development notebook...$(NC)"
	$(JUPYTER) notebook 02_model_development.ipynb

# Clean model development (no data leakage)
model-dev-clean:
	@echo "$(GREEN)Starting CLEAN Model Development notebook...$(NC)"
	$(JUPYTER) notebook 02_model_development_clean.ipynb

# Test the model training fix
test-fix:
	@echo "$(GREEN)Testing model training fix...$(NC)"
	$(PYTHON_VENV) quick_test_models.py

# Data preparation (for later phases)
data-prepare:
	@echo "$(GREEN)Preparing data...$(NC)"
	$(PYTHON_VENV) -c "print('Data preparation placeholder - implement in Phase 2')"

# Train model (for later phases)
train:
	@echo "$(GREEN)Training model...$(NC)"
	$(PYTHON_VENV) -c "print('Model training placeholder - implement in Phase 2')"

# Deploy locally (for later phases)
deploy-local:
	@echo "$(GREEN)Local deployment...$(NC)"
	$(PYTHON_VENV) -c "print('Local deployment placeholder - implement in Phase 5')"

# ===========================
# Phase 3: Cloud Infrastructure
# ===========================

# Initialize Terraform
terraform-init:
	@echo "$(GREEN)Initializing Terraform...$(NC)"
	cd infrastructure/terraform && terraform init

# Plan infrastructure for specific environment
terraform-plan-dev:
	@echo "$(GREEN)Planning development infrastructure...$(NC)"
	cd infrastructure/terraform && terraform plan -var-file="../environments/dev.tfvars"

terraform-plan-staging:
	@echo "$(GREEN)Planning staging infrastructure...$(NC)"
	cd infrastructure/terraform && terraform plan -var-file="../environments/staging.tfvars"

terraform-plan-prod:
	@echo "$(GREEN)Planning production infrastructure...$(NC)"
	cd infrastructure/terraform && terraform plan -var-file="../environments/prod.tfvars"

# Apply infrastructure for specific environment
terraform-apply-dev:
	@echo "$(GREEN)Deploying development infrastructure...$(NC)"
	cd infrastructure/terraform && terraform apply -var-file="../environments/dev.tfvars" -auto-approve

terraform-apply-staging:
	@echo "$(GREEN)Deploying staging infrastructure...$(NC)"
	cd infrastructure/terraform && terraform apply -var-file="../environments/staging.tfvars"

terraform-apply-prod:
	@echo "$(GREEN)Deploying production infrastructure...$(NC)"
	@echo "$(YELLOW)⚠️  Production deployment requires manual approval$(NC)"
	cd infrastructure/terraform && terraform apply -var-file="../environments/prod.tfvars"

# Destroy infrastructure (use with caution)
terraform-destroy-dev:
	@echo "$(RED)Destroying development infrastructure...$(NC)"
	cd infrastructure/terraform && terraform destroy -var-file="../environments/dev.tfvars" -auto-approve

terraform-destroy-staging:
	@echo "$(RED)Destroying staging infrastructure...$(NC)"
	cd infrastructure/terraform && terraform destroy -var-file="../environments/staging.tfvars"

# Get infrastructure outputs
terraform-output:
	@echo "$(GREEN)Getting infrastructure outputs...$(NC)"
	cd infrastructure/terraform && terraform output

# Build Docker images
docker-build-mlflow:
	@echo "$(GREEN)Building MLflow Docker image...$(NC)"
	cd infrastructure/docker/mlflow && docker build -t bank-churn-mlflow:latest .

# AWS CLI helpers
aws-check:
	@echo "$(GREEN)Checking AWS configuration...$(NC)"
	aws sts get-caller-identity || echo "$(RED)AWS CLI not configured$(NC)"

# One-command cloud setup for development
cloud-setup-dev: aws-check terraform-init terraform-apply-dev
	@echo "$(GREEN)✅ Development cloud infrastructure deployed!$(NC)"
	@echo "$(BLUE)Run 'make terraform-output' to see connection details$(NC)"

# Clean up development environment
cloud-cleanup-dev: terraform-destroy-dev
	@echo "$(GREEN)✅ Development infrastructure cleaned up$(NC)"

# Cloud deployment status
cloud-status:
	@echo "$(GREEN)Cloud Infrastructure Status:$(NC)"
	@echo "$(BLUE)Terraform State:$(NC)"
	cd infrastructure/terraform && terraform show -json | jq -r '.values.root_module.resources[] | select(.type == "aws_lb") | .values.dns_name' 2>/dev/null || echo "No load balancer found"

# Help for cloud commands
help-cloud:
	@echo "$(GREEN)Cloud Infrastructure Commands:$(NC)"
	@echo "  terraform-init          Initialize Terraform"
	@echo "  terraform-plan-dev      Plan dev infrastructure" 
	@echo "  terraform-apply-dev     Deploy dev infrastructure"
	@echo "  cloud-setup-dev         One-command dev setup"
	@echo "  cloud-cleanup-dev       Destroy dev infrastructure"
	@echo "  terraform-output        Show infrastructure outputs"
	@echo "  docker-build-mlflow     Build MLflow container"
	@echo "  aws-check               Verify AWS configuration"
	@echo "  cloud-status            Show deployment status" 