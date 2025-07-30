# 🚀 Virtual Environment Setup Guide

This guide will help you set up a virtual environment with all necessary libraries to run the Bank Customer Churn Prediction EDA notebook and the entire MLOps project.

## 📋 Prerequisites

- **Python 3.11** installed on your system
- **Git** (optional, for version control)
- **Make** (for Unix/Linux/macOS users - optional)

### Check Python Installation
```bash
python --version  # Should show Python 3.8 or higher
# or try
python3 --version
```

## 🛠️ Setup Options

### Option 1: Automated Setup (Recommended)

#### For macOS/Linux Users:
```bash
# Run automated setup
make setup

# Activate the environment
source venv/bin/activate

# Start Jupyter Notebook
make run-notebook
```

#### For Windows Users:
```cmd
# Navigate to the Project directory
cd Project

# Run automated setup
setup.bat

# The script will automatically activate the environment
# Start Jupyter Notebook
jupyter notebook
```

### Option 2: Manual Setup

#### Step 1: Create Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

#### Step 2: Install Dependencies
```bash
# Upgrade pip
pip install --upgrade pip

# Install all project dependencies
pip install -r requirements.txt
```

#### Step 3: Start Jupyter
```bash
# Start Jupyter Notebook
jupyter notebook

# Or start JupyterLab (modern interface)
jupyter lab
```

### Option 3: Minimal Setup (EDA Only)
If you only want to run the EDA notebook:

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install minimal dependencies
pip install pandas numpy matplotlib seaborn scipy plotly jupyter scikit-learn

# Start Jupyter
jupyter notebook 01_exploratory_data_analysis.ipynb
```

## 📁 Project Structure

```
Project/
├── 01_exploratory_data_analysis.ipynb  # Main EDA notebook
├── Customer-Churn-Records.csv          # Dataset
├── requirements.txt                    # All dependencies
├── Makefile                           # Automation (Unix/Linux/macOS)
├── setup.bat                          # Automation (Windows)
├── SETUP_GUIDE.md                     # This guide
├── README.md                          # Project overview
└── IMPLEMENTATION_PLAN.md             # Detailed project plan
```

## 🚀 Quick Start Commands

### Using Make (macOS/Linux)
```bash
make help           # Show all available commands
make setup          # Complete environment setup
make run-notebook   # Start Jupyter Notebook
make run-lab        # Start JupyterLab
make eda            # Start EDA notebook directly
make model-dev      # Start Model Development notebook
make check-env      # Basic environment check
make check-setup    # Comprehensive setup verification
make clean          # Clean up virtual environment
```

### Manual Commands
```bash
# Activate environment
source venv/bin/activate  # macOS/Linux
venv\Scripts\activate     # Windows

# Start specific notebook
jupyter notebook 01_exploratory_data_analysis.ipynb

# List installed packages
pip list

# Deactivate environment (when done)
deactivate
```

## 📊 Running the EDA Notebook

1. **Ensure virtual environment is activated**
2. **Start Jupyter Notebook:**
   ```bash
   jupyter notebook 01_exploratory_data_analysis.ipynb
   ```
3. **Run all cells** or execute step by step
4. **Expected outputs:**
   - Comprehensive data analysis
   - Visualizations and insights
   - `Customer-Churn-Records-Engineered.csv` (generated)
   - `feature_summary.json` (generated)

## 🐍 Dependencies Included

### Core Libraries (for EDA)
- `pandas` - Data manipulation
- `numpy` - Numerical computing
- `matplotlib` - Basic plotting
- `seaborn` - Statistical visualizations
- `plotly` - Interactive plots
- `scipy` - Statistical analysis
- `jupyter` - Notebook environment

### ML Libraries (for future phases)
- `scikit-learn` - Machine learning
- `xgboost` - Gradient boosting
- `lightgbm` - Efficient gradient boosting
- `mlflow` - Experiment tracking
- `optuna` - Hyperparameter optimization

### Development Tools
- `pytest` - Testing framework
- `black` - Code formatting
- `flake8` - Code linting
- `pre-commit` - Git hooks

## 🔧 Troubleshooting

### Common Issues:

**1. Python not found**
```bash
# Try using python3 instead of python
python3 -m venv venv
```

**2. Permission errors (Unix/Linux)**
```bash
# Make setup script executable
chmod +x setup.sh
```

**3. Package installation fails**
```bash
# Update pip first
pip install --upgrade pip

# Try installing with --user flag
pip install --user -r requirements.txt
```

**4. Jupyter kernel not found**
```bash
# Install kernel for virtual environment
python -m ipykernel install --user --name=venv
```

**5. seaborn style warning**
```bash
# This is a minor warning - the notebook will still work
# Update matplotlib if needed: pip install --upgrade matplotlib
```

### Memory Issues
If you encounter memory issues with large datasets:
```bash
# Increase Jupyter memory limit
jupyter notebook --NotebookApp.max_buffer_size=1000000000
```

## ✅ Verification

After setup, verify everything works:

### Option 1: Comprehensive Check (Recommended)
```bash
# Using make (macOS/Linux)
make check-setup

# Or run directly
python check_setup.py
```

### Option 2: Manual Check
```bash
# Check Python and key packages
python -c "import pandas, numpy, matplotlib, seaborn, plotly, scipy, sklearn; print('✅ All packages imported successfully!')"

# Check Jupyter
jupyter --version

# Check virtual environment
pip list | grep -E "(pandas|numpy|matplotlib|jupyter)"
```

## 🎯 Next Steps

1. **Run the EDA notebook** to understand the dataset
2. **Review the insights** and feature engineering opportunities
3. **Proceed to Phase 2** - Model Development (upcoming)
4. **Follow the implementation plan** in `IMPLEMENTATION_PLAN.md`

## 💡 Tips

- **Always activate the virtual environment** before working on the project
- **Use `deactivate`** when you're done working
- **Keep the environment clean** by only installing necessary packages
- **Update dependencies periodically** with `pip install --upgrade -r requirements.txt`

---

🚀 **Happy analyzing!** If you encounter any issues, refer to the troubleshooting section or check the project documentation. 