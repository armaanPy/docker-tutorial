# Simple Alpine Linux agent that will echo Hello World without any app src code, for the purpose of testing Docker Jenkins Pipeline.

FROM alpine:latest

USER root

RUN echo "Hello World"
