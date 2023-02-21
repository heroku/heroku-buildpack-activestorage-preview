FROM heroku/heroku:22-build.v98

WORKDIR /app
ENV WORKSPACE_DIR=/app
ENV S3_BUCKET=heroku-activestorage-default
ENV S3_PREFIX=dist_heroku-22_amd64/
ENV S3_REGION=s3.us-east-1
ENV STACK=heroku-22
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3-pip

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

COPY . /app
