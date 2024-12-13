FROM debian:bookwork-slim
EXPOSE 6680 6600
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
       build-essential \
       gettext \
       openssl \
       software-properties-common \
       apt-transport-https \
       wget \
       gnupg2 \
       python3 \
       python3-pip
RUN mkdir -p /etc/apt/keyrings && \
    wget -q -O /etc/apt/keyrings/mopidy-archive-keyring.gpg https://apt.mopidy.com/mopidy.gpg && \
    wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/bookworm.list && \
    apt list mopidy* > /mopidy_ext_list.txt && \
    apt install -y \
       mopidy \
       mopidy-local
RUN python3 -m pip install Mopidy-Pandora Mopidy-Youtube && \
#RUN mkdir -p -m 755 /media/music
CMD ["/usr/bin/mopidy"]

