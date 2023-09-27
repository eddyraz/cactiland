# Base image
FROM python:3.11-slim-bookworm

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1



ENV AWS_ACCESS_KEY_ID='AKIAUQQD6VGKLAUXLKNJ'
ENV AWS_SECRET_ACCESS_KEY='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'
ENV AWS_STORAGE_BUCKET_NAME='staging-propoerty-x-s3-bucket'
ENV AWS_DEFAULT_ACL='public-read'
ENV AWS_S3_REGION_NAME='ap-southeast-1'
ENV AWS_S3_ENDPOINT_URL='https://staging-propoerty-x-s3-bucket.s3.ap-southeast-1.amazonaws.com'
ENV AWS_S3_SIGNATURE_VERSION='s3v4'
ENV AWS_QUERYSTRING_AUTH='False'

ENV  DB_NAME=staging-property-x-db
ENV  DB_USER=propertyx_master
ENV  DB_PASSWORD=36]7~_C=Rv^h+fc
ENV  DB_HOST=staging-property-x-db.cx5vcxfpoebj.ap-southeast-1.rds.amazonaws.com
ENV  DB_PORT=5432

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
