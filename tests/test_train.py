import os
import pickle
import pandas as pd

def test_model_training():
    assert os.path.exists('model.pkl'), 'model.pkl not found after training.'
    with open('model.pkl', 'rb') as f:
        model = pickle.load(f)
    df = pd.read_csv('../Customer-Churn-Records.csv').dropna()
    clean_features = [
        'Geography', 'Gender', 'Age',
        'CreditScore', 'Tenure', 'Balance', 'EstimatedSalary',
        'NumOfProducts', 'HasCrCard', 'IsActiveMember'
    ]
    X = df[clean_features]
    X_enc = pd.get_dummies(X)
    # Load model columns
    with open('model_columns.pkl', 'rb') as f:
        model_columns = pickle.load(f)
    for col in model_columns:
        if col not in X_enc:
            X_enc[col] = 0
    X_enc = X_enc[model_columns]
    preds = model.predict(X_enc)
    assert len(preds) == len(X), 'Prediction length mismatch.' 