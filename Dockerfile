# Container image that runs your code
FROM alpine:3.10

# 
RUN apk add bash
RUN apk add grep

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY checkconflicts.sh /checkconflicts.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT [ "/checkconflicts.sh" ]
