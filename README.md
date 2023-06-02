# python-django-rest-api
Python Django Recipe Api



# Test to create Docker Image
docker build .
docker-compose up
docker-compose build

# run linting
flake8 tool used for test and linting.
docker-compose run --rm app sh -c "flake8"

# create django project or add django files in the project
docker-compose run --rm app sh -c "django-admin startproject app ."

# Github action and docker (https://docs.docker.com/build/ci/github-actions/)
Signup hub.docker.com
use "docker login" during our job
add secret to github project Examp DOCKERHUB_TOKEN and DOCKERHUB_USER


## create a config file at .github/workflows/checks.yml
#step1 set trigger
#step2 add steps for running and testing linting

## Run lint and unit test with  docker
docker-compose run --rm app sh -c "python manage.py test"

## Run development server
docker-compose up
