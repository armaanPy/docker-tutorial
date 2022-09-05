# Set base image (host OS)
FROM python:3.9-bullseye

# Set the working directory in the container
WORKDIR /code

# mysqlclient-2.1.1.tar.gz python setup.py egg_info did not run successfully. /bin/sh: mysql_config: not found.
# To resolve: https://pypi.org/project/mysqlclient/
RUN apt-get update
RUN apt-get install python3-dev default-libmysqlclient-dev build-essential -y

# Copy the requirements.txt file from local to the container working directory
COPY requirements.txt .

# Install dependencies from requirements.txt file
RUN pip install -r requirements.txt

# Copy the content of the local src directory to the working directory
COPY src/ .

# Command to run on container start
CMD ["python3.9", "app.py"]