# docker-tutorial

## The Case for Docker

- Shipping applications the traditional way is very manual, it is likely that you can have infrastructure and requirement changes which result in your apps breaking.
- Accelerate Developer Onboarding.
  - New hires can spin up entire environments in a matter of minutes.
- Eliminate App Conflicts.
  - v1 for old customers, v2 for new customers.
  - In Docker, the above is just 2 containers.
- Environment Consistency.
  - Run containers in all environments, machines all the same.
- Ship software faster.
- Docker Image is everything you need to run your application.
  - Apps can have a Frontend, APIs, Database.
  - You might want to run the Frontend on Nginx, or use Amazon RDS as the Database.
  - All of these requirements, along with the application source code, can be written into a Docker Image.
  - You can then ship the Docker Image into a container.

## Docker Images

- Docker Image defines the contents that are needed to run a container.
  - Your code
  - Server code
  - Environment variables
  - Security Settings
- Docker Image can be run as a container anywhere.
- Image is a read only template composed of layered filesystems used to share common files and create Docker container instances.

## Containers

- A container is an isolated and secured shipping container created from an image that can be run, started, stopped, moved and deleted.

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

## Cloud-native Microservices

- In the past applications just to be big and clunky and full of multiple features i.e. the Front-end, DB, logging, API calls.
- Microservices takes the same applications and breaks out each feature into its own smaller discrete service.
- Each service in a microservice is coded individually by separate teams, this is the microservices design pattern.
  - Take the different features of an app, break them out, and code them independently.
    - Patching
    - Dynamic scaling
- Can use docker-compose for multi-container apps.
  - i.e. Run a microservices app with multiple services, all from a declarative config file (docker-compose.yml) and deployed to a single Docker host.

## Docker Swarm

- Docker has a mode called Swarm mode that lets you cluster multiple Docker host into a secure, highly available cluster.
- The cluster comprises of managers and workers, we call the cluster a Swarm.
