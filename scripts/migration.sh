#!/bin/bash

source /root/venvs/env/bin/activate
cd /root/venvs/env/newproject

python manage.py migrate

expect -c 'spawn python manage.py createsuperuser --username=admin; expect "Email address:" {send -- "test@test.com\n"}; expect "Password:" {send -- "admin\n"}; expect "Password (again):" {send -- "admin\n"}; interact'


