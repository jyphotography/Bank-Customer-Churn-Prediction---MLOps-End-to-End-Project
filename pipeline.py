from prefect import flow, task
import subprocess

@task
def train():
    subprocess.run(['python', 'train.py'], check=True)

@task
def batch():
    subprocess.run(['python', 'batch.py'], check=True)

@task
def monitor():
    subprocess.run(['python', 'monitor.py'], check=True)

@flow
def churn_pipeline():
    train()
    batch()
    monitor()

if __name__ == "__main__":
    churn_pipeline() 