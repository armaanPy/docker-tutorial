## Environment Setup:

sudo apt install python3.9 <- Install Py3.9
sudo apt install python3.9-venv <- Install Py3.9 venv
python3.9 -m venv venv <- Create venv
source venv/bin/activate <- Activate the virtualenv
pip3.9 install Flask <- Install Flask (Web application framework)

## Building the Flask application:

cd /python3-docker/wired-brain/product-services
mkdir src; cd src
Copy app.py from Github into this location

## Executing the Flask application:

(Make sure you have activated the virtualenv)
python3.9 src/app.py

## Adding logging to the Python application:

Created logging_example_3.py & logging.ini.
logging_example_3.py takes config from logging.ini

In app.py:

- import logging.config

- # Configure the logging package from the logging ini file

  logging.config.fileConfig("logging.ini" disable_existing_loggers=False)

- # Get a logger for our module

  log = logging.getLogger(__name__)

- # Add the logging to functions
  log.debug('GET /products')
  log.exception('An exception occurred while retrieving products')
