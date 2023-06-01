FROM python:3.9-alpine3.13
LABEL maintainer="londonappdeveloper.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt  
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
# COPY requirements.txt .
# COPY requirements.dev.txt .

# RUN pip install -r requirements.txt

COPY ./app /app
# COPY app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv py
RUN py/bin/pip install --upgrade pip
RUN py/bin/pip install -r /tmp/requirements.txt
# Perform instructions conditionally based on the value of ARG
RUN if [ "$DEV" = "true" ]; then \
    echo "Running in development environment"; \
    RUN py/bin/pip install -r /tmp/requirements.dev.txt ; \
    else \
    echo "Running in production environment"; \
    # Add production-specific instructions here \
    fi