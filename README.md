# pyvirtualcam-docker

## Introduction

This is a Dockerfile to use [pyvirtualcam](https://github.com/letmaik/pyvirtualcam) on Docker container.

## Requirements

- Docker

## Preparation

### Build Docker image

```shell
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t pyvirtualcam:0.10.2 .
```

### Create Docker container

```shell
./launch_container.sh
```

## Example

### Create virtual camera

```shell
python examples/video.py <videofile>
```

### Capture

```shell
python examples/capture_example.py
```

## reference

- <https://github.com/letmaik/pyvirtualcam>
