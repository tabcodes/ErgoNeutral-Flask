# pull official base image
FROM python:3.10-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add gcc g++ python3-dev musl-dev

# add and run as non-root user
RUN adduser -D deployer

# install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# copy entrypoint.sh
# COPY ./entrypoint.sh .
# RUN chmod +x /usr/src/app/entrypoint.sh
# RUN chown deployer:deployer /usr/src/app

# USER deployer

# run entrypoint.sh
# ENTRYPOINT ["/usr/src/app/entrypoint.sh"]