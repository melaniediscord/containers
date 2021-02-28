FROM ubuntu:21.04
RUN sed -i '/^#\sdeb-src /s/^# *//' "/etc/apt/sources.list"
RUN apt-get update
RUN echo ttf-mscorefonts-installer \
   msttcorefonts/accepted-mscorefonts-eula \
   select true \
   |  debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive  apt-get build-dep python3-pil -y ;  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3-pip build-essential git
RUN pip install shortuuid Augmentor git+https://github.com/dimitrismistriotis/profanity-check discord.py numpy aiohttp nudepy --no-cache-dir && rm -rf ~/.cache 
RUN pip uninstall pillow -y && rm -rf ~/.cache  
RUN pip install --force-reinstall --no-cache-dir pillow-simd && rm -rf ~/.cache  
WORKDIR /data
CMD python3 /data/main.py