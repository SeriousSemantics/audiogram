FROM ubuntu:16.04

# Install dependencies
RUN apt-get update --yes && apt-get upgrade --yes
RUN apt-get install git nodejs npm \
libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev libpng-dev build-essential g++ \
ffmpeg nano clang \
redis-server --yes

RUN ln -s `which nodejs` /usr/bin/node

# Non-privileged user
RUN useradd -m audiogram
USER audiogram
WORKDIR /home/audiogram

# Clone repo
RUN git clone https://github.com/SeriousSemantics/audiogram.git
WORKDIR /home/audiogram/audiogram

# Install dependencies
RUN set NODE_OPTIONS=--max_old_space_size=24576
RUN node --max-old-space-size=24576 audiogram/waveform.js
RUN export CXX=clang++
RUN npm install --clang=1
CMD npm start
