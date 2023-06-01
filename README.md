# python-django-rest-api
Python Django Recipe Api

# run linting
docker-compose run --rm app sh -c "flake8"

# create django project
docker-compose run --rm app sh -c "django-admin startproject app .*"

# Github action and docker (https://docs.docker.com/build/ci/github-actions/)
Signup hub.docker.com
use "docker login" during our job
add secret to github project Examp DOCKERHUB_TOKEN and DOCKERHUB_USER


## create a config file at .github/workflows/checks.yml
#step1 set trigger
#step2 add steps for running and testing linting

## Run test in docker
docker-compose run --rm app sh -c "python manage.py test"
