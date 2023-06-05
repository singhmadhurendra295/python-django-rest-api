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
RUN python -m venv /py
RUN /py/bin/pip install --upgrade pip
RUN apk add --update --no-cache postgresql-client jpeg-dev && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev zlib zlib-dev linux-headers
RUN /py/bin/pip install -r /tmp/requirements.txt
# Perform instructions conditionally based on the value of ARG
RUN /bin/sh -c 'if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi' \
    && rm -rf /tmp \
    && apk del .tmp-build-deps
RUN adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"
USER django-user