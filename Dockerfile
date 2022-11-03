FROM ubuntu:22.04

ARG UID=1000
ARG GID=1000

# add new sudo user
ENV USERNAME pyvirtualcam
ENV HOME /home/$USERNAME
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        usermod  --uid $UID $USERNAME && \
        groupmod --gid $GID $USERNAME
RUN gpasswd -a $USERNAME video

# install package
RUN echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" > /etc/apt/apt.conf.d/docker-gzip-indexes
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        less \
        emacs \
        tmux \
        bash-completion \
        command-not-found \
        software-properties-common \
        curl \
        wget \
        coreutils \
        build-essential \
        git \
        git-lfs \
        python3-pip \
        python-is-python3 \
        libgl1-mesa-dev \
        v4l2loopback-utils \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/bin/bash", "-l", "-c"]
RUN python3 -m pip install -U pip
RUN pip3 install pyvirtualcam==0.10.2 opencv-python==4.5.5.64

COPY --chown=${USERNAME}:${USERNAME} install_v4l2loopback.sh /home/${USERNAME}/
ENTRYPOINT ["/bin/bash", "-c", "/home/${USERNAME}/install_v4l2loopback.sh"]
