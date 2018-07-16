FROM debian:stretch

MAINTAINER João Pedro Menegali Salvan Bitencourt (joao.ms@aluno.ifsc.edu.br)

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt -y -q upgrade && \
    apt -y -q install wget nano make python-pip python-dev python-setuptools curl libssl-dev libcurl4-openssl-dev libjpeg-dev libz-dev && \
    \
    wget 191.36.8.33/x264.tar.gz && \
    tar -xvf x264.tar.gz && \
    make install -C x264/ && \
    ldconfig && \
    rm -r x264* && \
    \
    wget 191.36.8.33/ffmpeg-3.4.tar.gz && \
    tar -xvf ffmpeg-3.4.tar.gz && \
    make install -C FFmpeg-release-3.4/ && \
    ldconfig && \
    rm -r ffmpeg-3.4.tar.gz FFmpeg-release-3.4 && \
    \
    wget 191.36.8.33/motion-4.1.tar.gz && \
    tar -xvf motion-4.1.tar.gz && \
    make install -C motion-4.1 && \
    ldconfig && \
    rm -r motion-4.1.tar.gz motion-4.1 && \
    \
    pip install motioneye && \
    mkdir -p /etc/motioneye && \
    cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf && \
    mkdir -p /var/lib/motioneye && \
    \
    rm -r /etc/localtime && \
    ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    \
    apt -y -q purge make && \
    apt clean && \
    apt clean cache && \
    unset DEBIAN_FRONTEND && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/* /root/.bash_history
    
ENTRYPOINT meyectl startserver -c /etc/motioneye/motioneye.conf
