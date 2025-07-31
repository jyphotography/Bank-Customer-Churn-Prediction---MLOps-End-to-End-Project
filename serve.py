from fastapi import FastAPI
import pandas as pd
import pickle

app = FastAPI()

# Load model and columns at startup
with open("model.pkl", "rb") as f:
    model = pickle.load(f)
with open("model_columns.pkl", "rb") as f:
    model_columns = pickle.load(f)

@app.post("/predict")
def predict(data: dict):
    # Convert input to DataFrame
    df = pd.DataFrame([data])
    # Ensure all columns are present
    for col in model_columns:
        if col not in df:
            df[col] = 0
    df = df[model_columns]
    pred = model.predict(df)[0]
    return {"prediction": int(pred)} 