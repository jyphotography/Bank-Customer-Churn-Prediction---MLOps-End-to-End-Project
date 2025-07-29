# Bank Customer Churn Prediction - MLOps End-to-End Project

## Problem Description

### Business Problem Statement

Customer churn represents one of the most critical challenges facing the banking industry. **It costs 5-10 times more to acquire a new customer than to retain an existing one**, making churn prevention a top priority for financial institutions. When customers leave, banks lose not only the immediate revenue but also the lifetime value of long-term relationships, cross-selling opportunities, and positive word-of-mouth referrals.

This project addresses the fundamental question: **Can we predict which bank customers are likely to churn before they actually leave, enabling proactive retention strategies?**

### Business Context and Impact

**Financial Impact:**
- Average customer acquisition cost in banking: $200-$2,000 per customer
- Average customer lifetime value: $2,000-$10,000+ over 5-10 years
- Even a 5% improvement in retention can increase profits by 25-95%

**Current Challenges:**
- Reactive approach: Banks typically discover churn after customers have already left
- Limited insight into early warning signals
- Inefficient allocation of retention resources
- Lack of personalized retention strategies

**Business Value of ML Solution:**
- **Proactive Intervention**: Identify at-risk customers 3-6 months before churn
- **Resource Optimization**: Focus retention efforts on high-value, high-risk customers
- **Personalized Retention**: Tailor retention strategies based on churn drivers
- **ROI Measurement**: Track effectiveness of ML-driven retention campaigns

### Dataset Overview

**Source**: [Kaggle - Bank Customer Churn Dataset](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn/data)

**Dataset Characteristics:**
- **Size**: ~10,000 customer records
- **Target Variable**: `Exited` (binary: 1 = churned, 0 = retained)
- **Feature Categories**:
  - **Demographic**: Age, Gender, Geography
  - **Financial**: CreditScore, Balance, EstimatedSalary
  - **Product Usage**: NumOfProducts, HasCrCard, IsActiveMember
  - **Relationship**: Tenure, Card Type, Points Earned
  - **Service Quality**: Complain, Satisfaction Score

**Key Predictive Features**:
- **Age**: Older customers typically show higher loyalty
- **Balance**: Higher account balances correlate with lower churn risk
- **IsActiveMember**: Active engagement reduces churn probability
- **NumOfProducts**: Cross-selling creates switching costs
- **Geography**: Regional differences in banking preferences
- **Complain/Satisfaction**: Service quality directly impacts retention

### Technical Approach

**Machine Learning Strategy:**
1. **Binary Classification Problem**: Predict churn probability (0-1 score)
2. **Model Ensemble**: Compare Logistic Regression, Random Forest, XGBoost
3. **Feature Engineering**: Create derived features (tenure buckets, balance ratios, etc.)
4. **Imbalanced Data Handling**: Address potential class imbalance with SMOTE/stratified sampling

**MLOps Implementation:**
- **Experiment Tracking**: MLflow for model versioning and metrics comparison
- **Model Registry**: Centralized model artifact management
- **Automated Pipelines**: Airflow orchestration for training/retraining
- **Multi-Modal Deployment**: Batch predictions + Real-time API
- **Monitoring**: Data drift detection and model performance tracking

### Success Metrics

**Business Metrics:**
- **Customer Retention Rate**: Target 5-10% improvement
- **Retention Campaign ROI**: Cost of intervention vs. saved customer value
- **Precision of High-Risk Identification**: Minimize false positives for cost efficiency

**Technical Metrics:**
- **Primary**: AUC-ROC (area under ROI curve) - target >0.85
- **Secondary**: Precision/Recall for top 10% predicted churn risk
- **Operational**: Model inference latency <100ms, training pipeline execution time

**Model Performance Thresholds:**
- **Minimum Viable**: AUC > 0.75 (better than random)
- **Production Ready**: AUC > 0.85 (strong predictive power)
- **Excellence**: AUC > 0.90 (industry-leading performance)

### Project Deliverables

1. **Production-Ready ML Pipeline**: End-to-end automated training and deployment
2. **Real-Time Prediction API**: RESTful service for live customer scoring
3. **Batch Prediction System**: Monthly churn risk assessment for all customers
4. **Monitoring Dashboard**: Track model performance and data quality
5. **Comprehensive Documentation**: Setup instructions, architecture, and usage guides

This project demonstrates enterprise-grade MLOps practices while solving a real business problem with measurable impact on customer retention and profitability. 