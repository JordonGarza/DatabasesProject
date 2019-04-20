# DatabasesProject


## Dependencies
* Python 3.7
* Django
* mysqlclient (python module)
* Pillow (python module)
* django-storages
* boto3
* numpy

### Linux (Ubuntu)
Set up virtual enviroment:
```
sudo apt-get install python3.7
virtualenv -p python3.7 venv3.7
source venv3.7/bin/activate # enter virtual enviroment
deactivate # exit virtual enviroment
```

Installing dependencies in terminal:
```
sudo apt-get install python3.7-dev
easy_install django
pip install mysqlclient
pip install Pillow
pip install boto3
pip install django-storages
pip install numpy
```

## Download

```
git clone https://github.com/JordonGarza/DatabasesProject.git
```

## Run
In terminal:
```
python manage.py runserver
```

