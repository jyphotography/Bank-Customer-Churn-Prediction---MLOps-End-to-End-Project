import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import mlflow
import pickle

# Load data
df = pd.read_csv('Customer-Churn-Records.csv')

# Define clean features (available before churn)
clean_features = [
    'Geography', 'Gender', 'Age',
    'CreditScore', 'Tenure', 'Balance', 'EstimatedSalary',
    'NumOfProducts', 'HasCrCard', 'IsActiveMember'
]

# Basic preprocessing: drop rows with missing values, encode categorical features
# (Assume 'Churn' is the target column, and it's binary)
df = df.dropna()
X = df[clean_features]
y = df['Exited'].astype(int)

# For simplicity, encode categoricals with get_dummies
df_encoded = pd.get_dummies(X)

# Train/test split
X_train, X_test, y_train, y_test = train_test_split(df_encoded, y, test_size=0.2, random_state=42)

# Train model
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

# Evaluate
y_pred = model.predict(X_test)
acc = accuracy_score(y_test, y_pred)
prec = precision_score(y_test, y_pred)
rec = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

# Log to MLflow
mlflow.set_experiment('churn-simple')
with mlflow.start_run():
    mlflow.log_metric('accuracy', acc)
    mlflow.log_metric('precision', prec)
    mlflow.log_metric('recall', rec)
    mlflow.log_metric('f1_score', f1)
    mlflow.sklearn.log_model(model, 'model')
    # Register the model in the MLflow Model Registry
    model_uri = f"runs:/{mlflow.active_run().info.run_id}/model"
    result = mlflow.register_model(model_uri, "ChurnModel")
    print(f"Model registered: {result.name}, version: {result.version}")

# Save model
with open('model.pkl', 'wb') as f:
    pickle.dump(model, f)
# Save model columns for batch prediction
with open('model_columns.pkl', 'wb') as f:
    pickle.dump(list(df_encoded.columns), f)

print(f"Model trained. Accuracy: {acc:.3f}") 