# docker-tutorial

## Deploying a Containerised App

- Start with Application Source Code
- Create a Dockerfile
- Use Docker and Dockerfile to build the Application Source Code into an image
  - docker image build
    - i.e. docker image build -t armaanpy/my_first_app:version1 .
- Use Docker to push this image into a repository/registry
  - docker image push
    - i.e. docker image push armaanpy/my_first_app:version1
- Use Docker to run/stop/start the image in its container
  - docker container run
    - i.e. docker container run -d --name my_first_app-web -p 8000:8080 armaanpy/my_first_app:version1
  - docker container stop
    - i.e. docker container stop my_first_app-web
  - docker container start
    - i.e docker container start my_first_app-web
