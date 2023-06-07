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
docker-compose build
docker-compose up


## Remove docker containers
PS E:\python-django-rest-api> docker-compose down
[+] Running 3/3
 ✔ Container python-django-rest-api-app-1  Removed                                                                 0.0s
 ✔ Container python-django-rest-api-db-1   Removed                                                                 0.0s
 ✔ Network python-django-rest-api_default  Removed


## create core app
docker-compose run --rm app sh -c "python manage.py startapp core"

## Run test locally
docker-compose run --rm app sh -c "python manage.py test"

[+] Running 1/0ango-rest-api> docker-compose run --rm app sh -c "python manage.py test"
 ✔ Container python-django-rest-api-db-1  Running                                                                                0.0s
Found 2 test(s).
System check identified no issues (0 silenced).
Waiting for database...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database available!
.Waiting for database...
Database available!
.
----------------------------------------------------------------------
Ran 2 tests in 0.030s

OK
PS E:\python-django-rest-api> docker-compose run --rm app sh -c "python manage.py wait_for_db"
[+] Running 1/0
 ✔ Container python-django-rest-api-db-1  Running                                                                                0.0s
Waiting for database...
Database available!


## Run linter 

PS E:\python-django-rest-api> docker-compose run --rm app sh -c "python manage.py wait_for_db && flake8"
[+] Running 1/0
 ✔ Container python-django-rest-api-db-1  Running                                                                                0.0s
Waiting for database...
Database available!
./core/admin.py:1:1: F401 'django.contrib.admin' imported but unused
./core/models.py:1:1: F401 'django.db.models' imported but unused
./core/management/commands/wait_for_db.py:27:69: W292 no newline at end of file
./core/tests/test_commands.py:34:64: W292 no newline at end of file


[+] Running 1/0ango-rest-api> docker-compose run --rm app sh -c "python manage.py test && flake8"
 ✔ Container python-django-rest-api-db-1  Running                                                                                0.0s
Found 2 test(s).
System check identified no issues (0 silenced).
Waiting for database...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database unavailable, waiting 1 second...
Database available!
.Waiting for database...
Database available!
.
----------------------------------------------------------------------
Ran 2 tests in 0.220s

OK
./core/admin.py:1:1: F401 'django.contrib.admin' imported but unused
./core/models.py:1:1: F401 'django.db.models' imported but unused