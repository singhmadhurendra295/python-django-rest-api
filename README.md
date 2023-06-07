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


## create migration after creating database model

directory where migration files stored core/migrations

PS E:\python-django-rest-api> docker-compose run --rm app sh -c "python manage.py makemigrations"
[+] Running 1/0
 ✔ Container python-django-rest-api-db-1  Running                                                                  0.0s
Migrations for 'core':
  core/migrations/0001_initial.py
    - Create model User

## apply migration into project

PS E:\python-django-rest-api> docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"
[+] Running 1/0
 ✔ Container python-django-rest-api-db-1  Running                                                                                0.0s
Waiting for database...
Database available!
Traceback (most recent call last):
  File "/app/manage.py", line 22, in <module>
    main()
  File "/app/manage.py", line 18, in main
    execute_from_command_line(sys.argv)
  File "/py/lib/python3.9/site-packages/django/core/management/__init__.py", line 446, in execute_from_command_line
    utility.execute()
  File "/py/lib/python3.9/site-packages/django/core/management/__init__.py", line 440, in execute
    self.fetch_command(subcommand).run_from_argv(self.argv)
  File "/py/lib/python3.9/site-packages/django/core/management/base.py", line 414, in run_from_argv
    self.execute(*args, **cmd_options)
  File "/py/lib/python3.9/site-packages/django/core/management/base.py", line 460, in execute
    output = self.handle(*args, **options)
  File "/py/lib/python3.9/site-packages/django/core/management/base.py", line 98, in wrapped
    res = handle_func(*args, **kwargs)
  File "/py/lib/python3.9/site-packages/django/core/management/commands/migrate.py", line 111, in handle
    executor.loader.check_consistent_history(connection)
  File "/py/lib/python3.9/site-packages/django/db/migrations/loader.py", line 327, in check_consistent_history
    raise InconsistentMigrationHistory(
django.db.migrations.exceptions.InconsistentMigrationHistory: Migration admin.0001_initial is applied before its dependency core.0001_initial on database 'default'.

## after having above error in running python manage.py migrate will do following steps

PS E:\python-django-rest-api> docker volume ls
DRIVER    VOLUME NAME
local     python-django-rest-api_dev-db-data
PS E:\python-django-rest-api> docker volume rm python-django-rest-api_dev-db-data
Error response from daemon: remove python-django-rest-api_dev-db-data: volume is in use - [97cf625f57c9b6c5ce168ac96238f1ca3e6a6dc02ccb455e8fb2c976248f547e]
PS E:\python-django-rest-api> docker-compose down
[+] Running 3/3
 ✔ Container python-django-rest-api-app-1  Removed                                                                               0.0s
 ✔ Container python-django-rest-api-db-1   Removed                                                                               0.4s
 ✔ Network python-django-rest-api_default  Removed                                                                               0.2s
PS E:\python-django-rest-api> docker volume rm python-django-rest-api_dev-db-data
python-django-rest-api_dev-db-data
PS E:\python-django-rest-api> docker volume ls
DRIVER    VOLUME NAME

## rerun migration

PS E:\python-django-rest-api> docker-compose run --rm app sh -c "python manage.py wait_for_db && python manage.py migrate"
[+] Running 3/3
 ✔ Network python-django-rest-api_default       Created                                                                          0.0s
 ✔ Volume "python-django-rest-api_dev-db-data"  Created                                                                          0.0s
 ✔ Container python-django-rest-api-db-1        Created                                                                          0.1s
[+] Running 1/1
 ✔ Container python-django-rest-api-db-1  Started                                                                                0.4s
Waiting for database...
Database unavailable, waiting 1 second...
Database available!
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, core, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0001_initial... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying core.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying sessions.0001_initial... OK

  