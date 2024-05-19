#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install pyenv if not already installed
if ! command -v pyenv &> /dev/null
then
    echo "pyenv not found, installing..."
    curl https://pyenv.run | bash

    # Add pyenv to shell startup file
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    source ~/.bashrc
else
    echo "pyenv found, skipping installation..."
fi

# Update pyenv if already installed
pyenv update

# Install Python 3.8.10 and set it as global
echo "Installing Python 3.8.10..."
pyenv install 3.8.10 -s
pyenv global 3.8.10

# Verify Python version
echo "Python version:"
python --version  # Should output Python 3.8.10

# Remove existing virtual environment if it exists
if [ -d "myenv38" ]; then
  echo "Removing existing virtual environment..."
  rm -rf myenv38
fi

# Create and activate a new virtual environment with Python 3.8
echo "Creating virtual environment..."
python -m venv myenv38
source myenv38/bin/activate

# Upgrade pip to the required version (21.0)
echo "Upgrading pip to version 21.0..."
python -m pip install --upgrade pip==21.0

# Install dependencies
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

echo "Setup complete!"

