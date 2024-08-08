FROM ubuntu:22.04

ARG UBUNTU_GROUP
ARG UBUNTU_USR
ARG UBUNTU_USR_PASS

# Install essential packages and add a user
RUN apt-get update && \
    apt-get install -y sudo nano tzdata && \
    apt-get clean && \
    groupadd "${UBUNTU_GROUP}" && \
    useradd -m -g "${UBUNTU_GROUP}" "${UBUNTU_USR}" && \
    echo "${UBUNTU_USR}:${UBUNTU_USR_PASS}" | chpasswd && \
    echo "${UBUNTU_USR} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${UBUNTU_USR}
ENV HOME=/home/${UBUNTU_USR}

WORKDIR ${HOME}

# Copy the shell script to the container
COPY --chown="$UBUNTU_USR":"$UBUNTU_GROUP" pipthon_tools.sh .

# Make the script executable and run it
RUN chmod u+x ./pipthon_tools.sh
RUN ./pipthon_tools.sh

# Set PATH
ENV PATH="${HOME}/.local/bin:${PATH}"
