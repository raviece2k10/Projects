FROM ravikumsingh/myubuntu:22.04
MAINTAINER ravikumsingh
RUN apt-get update -y
RUN apt-get install git -y
RUN git clone https://github.com/raviece2k10/Projects.git