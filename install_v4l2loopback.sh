#! /bin/bash

sudo apt update
sudo apt -y install v4l2loopback-dkms
sudo modprobe v4l2loopback devices=1

/bin/bash