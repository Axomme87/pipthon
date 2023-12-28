FROM ubuntu:22.04

ARG UBUNTU_GROUP
ARG UBUNTU_USR
ARG UBUNTU_USR_PASS

RUN apt-get update &&  \
    apt-get -y install sudo &&  \
    apt-get -y install nano &&  \
    apt-get clean

RUN groupadd "$UBUNTU_GROUP"
RUN useradd -m -g "$UBUNTU_GROUP" "$UBUNTU_USR"

RUN echo "$UBUNTU_USR:$UBUNTU_USR_PASS" | chpasswd
RUN echo "$UBUNTU_USR  ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER $UBUNTU_USR
ENV HOME=/home/$UBUNTU_USR
RUN chown "$UBUNTU_USR":"$UBUNTU_GROUP" -R "$HOME"

WORKDIR $HOME

COPY pipthon_tools.sh .
# COPY pyproject.toml .
# COPY README.md .

# ENV PATH="$HOME/.local/bin:$PATH"
# RUN pip install --upgrade pip setuptools wheel poetry
# RUN poetry config virtualenvs.in-project true --local
# RUN poetry install --without dev
# ENV PATH="$HOME/app/.venv/bin:$PATH"

# CMD ["python", "-m", "src.main"]
