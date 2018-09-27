FROM fedora:28

MAINTAINER mauricioesguerra <mauricio.esguerra@gmail.com>

RUN dnf -y update 
RUN dnf -y install make gcc-gfortran libgfortran-static openmpi openmpi-devel git
RUN dnf clean all

RUN git clone https://github.com/esguerra/q6.git /root/q6
RUN cd /root/q6/src

