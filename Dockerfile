FROM ubuntu
RUN apt-get update
RUN apt-get install -y sudo git bc acl gawk netcat

# Copy all the scripts in the current directory into the /scripts directory
COPY . /scripts
WORKDIR /scripts

RUN ./genStudent.sh
RUN ./permit.sh

USER HAD
WORKDIR /home/HAD

ENTRYPOINT ["/scripts/entrypoint.sh"]