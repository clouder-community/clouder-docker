FROM clouder/clouder-base
MAINTAINER Yannick Buron yburon@goclouder.net

RUN apt-get update -qq && apt-get install -qqy \
apt-transport-https \
ca-certificates \
lxc \
iptables sudo supervisor

# Install Docker from Docker Inc. repositories.
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
&& apt-get update -qq \
&& apt-get install -qqy lxc-docker

RUN echo "" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:docker]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/etc/init.d/docker start" >> /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
