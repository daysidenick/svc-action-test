FROM ubuntu:22.04
MAINTAINER nick
WORKDIR /
USER root
RUN useradd -ms /bin/bash -p '$6$5RFdnXZJWWCQykyt$VJw5IXFNdh5qSsLXvKmR7U17BSjIrJR79X/L1qbgxww69vHf5sDiHxweKYsardD094iDK2FAKqBWGpnuy1LQa.' acpsvc \
        && groupmod -g 2001 acpsvc \
        && usermod -u 2001 acpsvc \
        && apt-get update \
        && apt-get install -y build-essential software-properties-common \
        && add-apt-repository main universe multiverse \
        && apt-get update \
        && ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
        && apt-get install -y binutils bison build-essential cpp curl flex gcc-11 g++-11 init iputils-ping jq language-pack-ko libatlas-base-dev libfl-dev libsndfile1 make net-tools patchelf python3 python3-venv systemd tree tzdata unzip vim wget \
        && apt-get clean autoclean \
        && apt-get autoremove -y \
        && rm -vrf /var/lib/{apt,cache,dpkg,log} \
        && dpkg-reconfigure -f noninteractive tzdata \
        && dpkg-reconfigure locales \
        && locale-gen ko_KR.UTF-8 \
        && /usr/sbin/update-locale LANG=ko_KR.UTF-8 \
        && echo Asia/Seoul > /etc/timezone
ENTRYPOINT ["/sbin/init"]
USER acpsvc
COPY --chown=acpsvc kube-profile /
RUN /bin/bash /profile/profile.sh
