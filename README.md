# docker-tutorial

## Documentation

### The Case for Docker

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

### Docker Images

- Docker Image defines the contents that are needed to run a container.
  - Your code
  - Server code
  - Environment variables
  - Security Settings
- Docker Image can be run as a container anywhere.
- Image is a read only template composed of layered filesystems used to share common files and create Docker container instances.

### Containers

- A container is an isolated and secured shipping container created from an image that can be run, started, stopped, moved and deleted.

## Docker Compose

- Docker Compose defines services using a YAML configuration file.
  - A service is basically a container at runtime.
- Docker Compose can:
  - Build one or more images.
  - Start and stop services.
  - View the status of running services.
  - Stream the log ouput of running services.

## Docker Compose Commands

- docker-compose build
  - Will take docker-compose YAML file and based on the services defined there will build our images.
- docker-compose up
  - Run the containers and bring them up.
- docker-compose down
  - Bring everything down.

## Communication between multiple Containers

- Lets say you have an application with a frontend UI, some API's and a backend database, and all of these services are running in separate containers.
  - All of these containers will need to communicate with each other to work.
    - We can do this with a Bridge Network.

## Bridge Network

- A Bridge Network is a way to create a bridge so that data can flow between containers.
  - This allows containers and the services within them to actually talk to each other back and forth.
    - As long as they have access to that bridge, they can talk.

### Dockerfiles

- Dockerfiles work similar to a compiler that will compile code into a binary.
- A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.
- Think of a Dockerfile as a layered cake, where each layer is a different instruction.
  - FROM | node:alpine -> [Set the base image for the Dockerfile]
    LABEL | author="Armaan Hussain" -> [Metadata about the Dockerfile]
    ENV | NODE_ENV=production -> [Environment variable, becomes part of the image]
    WORKDIR | /var/www -> [Where does your application source code live that start things off]
    COPY | . . -> [Copy in config files, settings, code, COPY [FROM] [TO]]
    RUN | npm install -> [Run different commands, i.e. install npm packages]
    EXPOSE | 3000 -> [Expose whichever port your webserver is going to be listening on]
    ENTRYPOINT | ["node", "server.js"] -> [The first command we are gonna run to start the Dockerfile up]
- https://docs.docker.com/engine/reference/builder/

### Volumes

- Containers live and die, when a container dies, any file inside it dies.
- Volume Usage Scenarios:
  - Store log files outside of container.
  - Store database files outside of containers.
  - Cache files.
  - Etc...

### Cloud-native Microservices

- In the past applications just to be big and clunky and full of multiple features i.e. the Front-end, DB, logging, API calls.
- Microservices takes the same applications and breaks out each feature into its own smaller discrete service.
- Each service in a microservice is coded individually by separate teams, this is the microservices design pattern.
  - Take the different features of an app, break them out, and code them independently.
    - Patching
    - Dynamic scaling
- Can use docker-compose for multi-container apps.
  - i.e. Run a microservices app with multiple services, all from a declarative config file (docker-compose.yml) and deployed to a single Docker host.

### Docker Swarm

- Docker has a mode called Swarm mode that lets you cluster multiple Docker host into a secure, highly available cluster.
- The cluster comprises of managers and workers, we call the cluster a Swarm.

### Provision Containerized Agents

- Enable "Expose daemon on tcp://localhost:2375 without TLS" on Docker Desktop
- Jenkins - Manage Agents
  - Configure Clouds
    - Docker
      - Docker Host URL: tcp://host.docker.internal:2375
        - Check "Enabled"
        - Check "Expose DOCKER_HOST"
  - Docker Agent templates
    - Labels: Agent
    - Check "Enabled"
    - Name: Jenkins Agent
    - Docker Image: jenkins/jenkins:lts
    - Instance Capacity: 10
    - Remote File System Root: /var/jenkins_home
  - To test...
    - Job - Configure
    - General
      - Restrict where this project can be run: Agent

## Implementation

### Summary of how to deploy a Containerised App

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

### Building a Custom Image

- The simplest way to build an image would be the following:

  - docker build -t <name> .

- Extended method of tagging your image
  - docker build -t <registry>/<name>:<tag> .
    - i.e. docker build -t prime-quants-ahussain/nodeexpressapp:1.0 .

### Deploy an Application Image to a Registry

- How to push your image up to your registry (Internal, Docker Hub, Amazon ECR etc)

  - docker push <username>/<image_name>:<tag>
    - i.e. docker push armaanpy/nodeexpressapp:1.0

- How to pull your image from registry to another machine
  - docker pull <username>/<image_name>:<tag>
    - i.e. docker pull armaanpy/nodeexpressapp:1.0

### Deleting an Image

- docker images
- docker rmi [image_id] <- Can just include the first 3 characters of the image id

### Running a Container

- docker run -p <externalPort>:<internalPort> --name <Name> -d <imageName>
  - i.e. docker run -p 8081:80 --name nginx -d nginx:alpine

### Stopping a Container

- docker ps -a <- To find all containers
- docker ps <- To find all running container
- docker stop [container_id] <- Can just include the first 3 characters of the container id

### Deleting a Container

- docker rm -f [container_id] <- Can just include the first 3 characters of the container id

### View Container Logs

- docker logs <containerId>
- docker-compose logs <- View the logs for all Docker Compose services
- docker-compose logs <- View the logs for specific Docker Compose services
- docker-compose logs --tail=5 <- View last 5 lines
- docker-compose logs --follow <- Follow the log output

### Creating a Container Volume

- docker run -p <externalPort>:<internalPort> -v </[volume]/> <imageToRun>
  - The above is asking for the data in volume -v to be stored on the Docker host
- If you want to control the folder location where it writes to:
  - docker run -p <externalPort>:<internalPort> -v $(pwd):/var/www/logs <ImageToRun>

### Create a Bridge Network

- To create network:

  - docker network create --driver bridge [network_name]

- To list the networks:

  - docker network ls

- To remove a network:

  - docker network rm [network]

- To run a DB container in a network:

  - docker run -d --net=nodeexpress_network --name=mongodb mongo

- To run an app container in a network:

  - docker run -d -p 3000:3000 --net=nodeexpress_network --name=nodeapp armaanpy/nodeexpressapp

- To check if the containers are successfully in the network:
  - docker network ls <- To get the network ID's
  - docker network inspect [network_id]
    - Scroll down to the "Containers: {..}" section

### Shell into a Container

- docker exec -it <containerId> sh
- docker-compose exec <serviceName> <shell> <- Allocates tty itself

### Pushing images with Docker Compose

- docker-compose push <- Push all the images up
- docker-compose push [service...] <- Push whatever image is specified within said service

### Scaling Containers

- Normally, a single contai ner is created per service you specify.
  - docker-compose up -d --scale <service>=4 <- Scale 4 containers for service
- If you do this, do NOT define a host port for your service, as you cannot have multiple containers on the same port.
  - INSTEAD go from this:
    ports:
    - "3000:3000"
  - To this:
    ports:
    - "3000"

# Git commit overwrite - 31/08/22
