FROM python:3.9.7-slim-buster

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git wget pv jq python3-dev ffmpeg mediainfo \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Create downloads directory
RUN mkdir -p downloads

# Run both Flask server and Pyrogram bot
CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:8000 & python3 main.py"]
