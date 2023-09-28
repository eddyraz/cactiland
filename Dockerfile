# Base image
FROM python:3.11-slim-bookworm

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1





# Set the working directory
WORKDIR /app

# Copy requirements file
COPY ./requirements requirements

# Install dependencies
RUN pip install -r requirements/deploy.txt 

# Copy application code
COPY . .

# Collect static files
RUN python manage.py collectstatic --settings=config.settings.deployment --no-input

# Expose port 8000
EXPOSE 8000

# Run the web server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers" , "2"  , "config.wsgi"]
