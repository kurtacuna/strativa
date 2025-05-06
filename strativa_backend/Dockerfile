# For development, run:
# docker run --name strativa_backend -p 8000:8000 --env-file .env.development -v "$(pwd):/strativa_backend" strativa_backend:latest

# For deployment, rebuild the image to reflect changes in the code

# Python base image
FROM python:latest

# Install postgres-client
RUN apt-get update && apt-get install -y postgresql-client

# Change to a directory
WORKDIR /strativa_backend

# Copy requirements.txt to workdir
COPY requirements.txt .

# Install packages
RUN pip install -r requirements.txt

# Copy the rest of the files to workdir
COPY . .

# Expose port for documentation
EXPOSE 8000

# Execute commands (CMD) in compose.yaml