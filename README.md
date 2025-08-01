# Customer Churn ML Ops Project

## Problem Description

### Business Problem Statement
Customer churn represents one of the most critical challenges facing the banking industry. It costs 5-10 times more to acquire a new customer than to retain an existing one, making churn prevention a top priority for financial institutions. When customers leave, banks lose not only the immediate revenue but also the lifetime value of long-term relationships, cross-selling opportunities, and positive word-of-mouth referrals.

This project addresses the fundamental question: **Can we predict which bank customers are likely to churn before they actually leave, enabling proactive retention strategies?**

By leveraging historical customer data, this project aims to build a machine learning pipeline that predicts the likelihood of customer churn. The goal is to empower banks to identify at-risk customers early and take targeted actions to improve retention, reduce revenue loss, and enhance customer satisfaction.

**Source**: [Kaggle - Bank Customer Churn Dataset](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn/data)


## Project Structure
- `Customer-Churn-Records.csv`: The dataset used for training and evaluation.
- `train.py`: Script to train a simple model, log metrics, and register the model in MLflow.
- `batch.py`: Script to run batch predictions using the trained model.
- `monitor.py`: Script to monitor model performance on new data.
- `serve.py`: FastAPI app for model serving.
- `pipeline.py`: Prefect workflow to orchestrate the full pipeline.
- `Dockerfile`: Containerizes the model serving API for cloud deployment.
- `requirements.txt`: List of dependencies (including versions).
- `Makefile`: Commands to run the pipeline easily.
- `tests/`: Unit and integration tests.

---

## Quickstart

1. **Set up a virtual environment (recommended)**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```
3. **Run the orchestrated pipeline with Prefect**
   ```bash
   python pipeline.py
   ```
   This will execute the full workflow: training, batch prediction, and monitoring.
4. **(Optional) Run steps individually**
   ```bash
   make train
   make batch
   make monitor
   make test
   ```

---

## Containerized Model Deployment

This project includes a FastAPI app (`serve.py`) and a `Dockerfile` for containerized model serving. You can run the model as a web service and deploy it to the cloud or any container platform.

### Build and Run Locally

1. **Build the Docker image**
   ```bash
   docker build -t churn-model-api .
   ```
2. **Run the container**
   ```bash
   docker run -p 8000:8000 churn-model-api
   ```
3. **Send a prediction request**
   ```bash
   curl -X POST "http://localhost:8000/predict" \
        -H "Content-Type: application/json" \
        -d '{"Geography": "France", "Gender": "Female", "Age": 42, "CreditScore": 600, "Tenure": 3, "Balance": 0.0, "EstimatedSalary": 50000, "NumOfProducts": 1, "HasCrCard": 1, "IsActiveMember": 1}'
   ```

### Deploy to Cloud
- Push your Docker image to a registry (e.g., Docker Hub, AWS ECR, GCP Artifact Registry).
- I am using the AWS
**Prerequisites:**
- AWS CLI installed and configured (`aws configure`)
- Docker installed and running

**Step 1: Build and Push to AWS ECR**
```bash
# Use the automated deployment script
chmod +x deploy_to_aws.sh
./deploy_to_aws.sh

# Or run manually:
# 1. Build the Docker image
docker build -t churn-model-api .

# 2. Create ECR repository (replace YOUR_REGION)
aws ecr create-repository --repository-name churn-model-api --region us-east-1

# 3. Get login token and authenticate
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com

# 4. Tag and push image
docker tag churn-model-api:latest $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com/churn-model-api:latest
docker push $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com/churn-model-api:latest
```

**Step 2: Deploy to AWS Services**
- **AWS ECS**: Create an ECS service using the ECR image URI
- **AWS App Runner**: Deploy directly from ECR with auto-scaling
- **AWS Lambda**: Package as container image for serverless deployment
- **AWS EKS**: Deploy to Kubernetes cluster using the ECR image

---

## Model Monitoring
- `monitor.py` calculates and prints churn rate and accuracy from predictions.
- Easily extensible to add alerts or dashboards (e.g., with Evidently).

---

## Testing & Best Practices
- **Unit tests:** `tests/test_train.py` checks model file and predictions.
- **Integration tests:** `tests/test_integration.py` runs the full pipeline.
- **Makefile:** Simplifies running all steps and tests.
- **Linter suggestion:** Use `black` or `flake8` for code formatting.
- **CI/CD ready:** Structure supports adding GitHub Actions or other CI/CD tools.

---

---

## Evaluation Criteria Mapping

| Criteria                        | How This Project Meets It                                                                                 |
|---------------------------------|----------------------------------------------------------------------------------------------------------|
| **Problem description**         | Clear description and context provided in this README.                                                   |
| **Cloud**                       | Project is containerized (Docker) and ready for deployment to any cloud/container platform.              |
| **Experiment tracking & registry** | MLflow is used for experiment tracking and model registry.                                               |
| **Workflow orchestration**      | Prefect orchestrates the full pipeline (train, batch, monitor).                                          |
| **Model deployment**            | FastAPI app + Dockerfile for containerized, cloud-ready deployment.                                      |
| **Model monitoring**            | Monitoring script calculates and reports metrics; extensible for alerts.                                 |
| **Reproducibility**             | Clear instructions, requirements.txt, venv setup, and Makefile.                                          |
| **Best practices**              | Unit and integration tests, Makefile, linter suggestion, CI/CD ready structure.                          |

---

## Appendix: Debugging with MLflow UI and Prefect UI

### MLflow UI
MLflow provides a web UI to track experiments, runs, and models.

To launch the MLflow UI, run:
```bash
mlflow ui
```
By default, it will be available at [http://localhost:5000](http://localhost:5000).

- You can browse experiments, runs, parameters, metrics, and artifacts.
- The Model Registry tab allows you to view and manage registered models.

If your tracking URI or artifact location is custom, you may need to specify it with `--backend-store-uri` and `--default-artifact-root`.

### Prefect UI
Prefect provides a UI for visualizing and managing flows.

To launch the Prefect UI, run:
```bash
prefect server start
```
This will start the Prefect Orion server and UI. By default, the UI will be available at [http://localhost:4200](http://localhost:4200).

- You can view flow runs, logs, and task statuses.
- Useful for debugging and monitoring more complex workflows.

For more details, see the [Prefect documentation](https://docs.prefect.io/).

---
