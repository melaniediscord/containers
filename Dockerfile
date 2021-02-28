# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
FROM oraclelinux:8-slim

COPY python38.module /etc/dnf/modules.d/python38.module

RUN microdnf install python38 \
                     python38-libs \
                     python38-pip \
                     python38-setuptools oraclelinux-release-el8 && \
    microdnf clean all

# added rpms
RUN curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -o epel.rpm && rpm -i epel.rpm
RUN sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/*

RUN microdnf install   glibc \
openblas-threads  \
freetype \
lcms2 \
libjpeg-turbo \
libtiff \
libwebp \
openjpeg2 \
platform-python \
python3-libs \
zlib \
libgcc \
libgfortran \
libquadmath \
libstdc++ \
openblas \
python38-devel \
python3-numpy \
python3-numpy-f2py \
python3-six \
bzip2-libs \
cairo \
fftw-libs-double \
fontconfig \
gdk-pixbuf2 \
glib2 \
graphviz \
ilmbase \
jbigkit-libs \
libgomp \
libgs \
libICE \
libpng \
libraqm \
LibRaw \
librsvg2 \
libSM \
libtool-ltdl \
libwmf-lite \
libX11 \
libXext \
libxml2 \
libXt \
OpenEXR-libs \
pango \
xz-libs \
autoconf \
automake \
git \
bzip2-devel \
fftw-devel \
freetype-devel \
gcc \
gcc-c++ \
giflib-devel \
graphviz-devel \
ilmbase-devel \
jasper-devel \
jbigkit-devel \
lcms2-devel \
libgs-devel \
libjpeg-turbo-devel \
libpng-devel \
libraqm-devel \
LibRaw-devel \
librsvg2-devel \
libtiff-devel \
libtool-ltdl-devel \
libwebp-devel \
libwmf-devel \
libX11-devel \
libXext-devel \
libxml2-devel \
libXt-devel \
OpenEXR-devel \
openjpeg2-devel \
perl-devel \
perl-generators  nodejs \
zlib-devel && microdnf clean all
RUN curl https://download.imagemagick.org/ImageMagick/download/linux/CentOS/x86_64/ImageMagick-libs-7.0.11-1.x86_64.rpm -o libs.rpm  && rpm -i  libs.rpm && curl https://download.imagemagick.org/ImageMagick/download/linux/CentOS/x86_64/ImageMagick-7.0.11-1.x86_64.rpm -o image.rpm && rpm -i image.rpm && rm -rf *.rpm
COPY /Users/m/Code/melanie-docker/ffmpeg-4.3.2-amd64-static/ffmpeg  /usr/bin/ffmpeg
WORKDIR /
COPY requirements.txt requirements.txt
RUN python3.8 -m pip install --no-cache-dir -U pip setuptools wheel &&  rm -rf ~/.cache/pip 
RUN python3.8 -m pip install --no-cache-dir -r requirements.txt --no-cache-dir && rm -rf ~/.cache/pip 
RUN python3.8 -m pip uninstall pillow -y && pip install --no-cache-dir --force-reinstall pillow-simd mujson && rm -rf ~/.cache/pip 
RUN python3.8 -m pip install Red-DiscordBot  && rm -rf~/.cache/pip 
RUN mkdir -p /root/.config/Red-DiscordBot


CMD python3.8 -m redbot $START_OPTIONS

