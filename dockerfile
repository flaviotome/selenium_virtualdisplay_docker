# # Use a lightweight base image; here we use the official Python 3.9 slim image
# FROM python:3.9-slim

# # Set non-interactive frontend (useful for automatic installs)
# ENV DEBIAN_FRONTEND=noninteractive

# # Set the working directory inside the container
# WORKDIR /app

# # Install system dependencies for Firefox and wget
# RUN apt-get update && apt-get install -y \
#     firefox-esr \
#     wget \
#     xvfb \
#     && rm -rf /var/lib/apt/lists/*

# # Download and install Geckodriver
# RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-linux64.tar.gz" -O geckodriver.tar.gz \
#     && tar -xzf geckodriver.tar.gz -C /usr/local/bin \
#     && rm geckodriver.tar.gz \
#     && chmod +x /usr/local/bin/geckodriver

# # Copy the requirements file into the container
# #COPY requirements.txt ./requirements.txt

# # Install the dependencies
# #RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install --no-cache-dir selenium pyvirtualdisplay pillow streamlit

# # Copy the Streamlit application files into the container
# COPY . .

# # Expose the Streamlit port; Streamlit runs on 8501 by default
# EXPOSE 8501

# # Command to run the Streamlit application
# #CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
# # Command to run the Streamlit application along with Xvfb
# #CMD Xvfb :99 -screen 0 1280x720x16 & export DISPLAY=:99 && streamlit run app.py --server.port=8501 --server.address=0.0.0.0
# CMD Xvfb :99 -screen 0 1280x720x16 & export DISPLAY=:99 && streamlit run app.py --server.port=$PORT --server.address=0.0.0.0

# Use a lightweight base image; here we use the official Python 3.9 slim image
FROM python:3.9-slim

# Set non-interactive frontend (useful for automatic installs)
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies for Firefox and wget
RUN apt-get update && apt-get install -y \
    firefox-esr \
    wget \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Download and install Geckodriver
RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-linux64.tar.gz" -O geckodriver.tar.gz \
    && tar -xzf geckodriver.tar.gz -C /usr/local/bin \
    && rm geckodriver.tar.gz \
    && chmod +x /usr/local/bin/geckodriver

# Install the dependencies
RUN pip install --no-cache-dir selenium pyvirtualdisplay pillow streamlit

# Copy the Streamlit application files into the container
COPY . .

# Expose the Streamlit port; Streamlit runs on 8501 by default
EXPOSE $PORT

# Ensure commands below run in the shell form to use the PORT environment variable provided by Cloud Run
# CMD Xvfb :99 -screen 0 1280x720x16 & \
#     export DISPLAY=:99 && \
#     streamlit run app.py --server.port=$PORT --server.address=0.0.0.0 --server.enableCORS=false --server.enableXsrfProtection=false

# Command to run the start script
CMD ["./start.sh"]