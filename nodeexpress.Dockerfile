# Give the base image (Node.js:Version18 ofAlpine)
# Should be very explicit here and NOT use just "alpine" as versions could change over time and ruin your build
FROM node:18-alpine

# Optional but important metadata about the Dockerfile
LABEL author="Armaan Hussain"

# Supplying environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Define the working directory of the docker container 
WORKDIR /home/armaan/nodeexpressmongodb

# Copy package[-lock].json to working directory as they are needed to run npm install
COPY ./nodeexpressmongodbdockerapp/package.json ./nodeexpressmongodbdockerapp/package-lock.json ./

# Run npm install which installs all modules that are listed in package.json file
RUN npm install

# Copy all the source code from local to working directory
COPY ./nodeexpressmongodbdockerapp/* ./

# Expose a port to inform Docker that the container listens on the specified network ports at runtime. 
EXPOSE $PORT

# Specify what to run when the Dockerfile starts up
ENTRYPOINT [ "npm", "start" ]