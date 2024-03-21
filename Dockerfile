FROM alpine:latest

RUN apk update

RUN apk add --no-cache \
    bash \
    curl \
    file \
    git \
    iproute2 \
    mc \
    openssh-client \
    unzip \
    vim \
    ;

RUN apk add --no-cache \
    htop \
    openrc \
    openssh \
    openssh-keygen \
    rsyslog \
    ;

RUN sed -i \
    's/^\(tty\d\:\:\)/#\1/g' /etc/inittab 

RUN sed -i \
    -e 's/#rc_sys=".*"/rc_sys="docker"/g' \
    -e 's/#rc_env_allow=".*"/rc_env_allow="\*"/g' \
    -e 's/#rc_crashed_stop=.*/rc_crashed_stop=NO/g' \
    -e 's/#rc_crashed_start=.*/rc_crashed_start=YES/g' \
    -e 's/#rc_provide=".*"/rc_provide="loopback net"/g' \
    /etc/rc.conf 

RUN rm -f \
    /etc/init.d/hwdrivers \
    /etc/init.d/hwclock \
    /etc/init.d/hwdrivers \
    /etc/init.d/modules \
    /etc/init.d/modules-load \
    /etc/init.d/modloop

RUN sed -i \
    's/cgroup_add_service /# cgroup_add_service /g' \
    /lib/rc/sh/openrc-run.sh 

RUN sed -i \
    's/VSERVER/DOCKER/Ig' \
    /lib/rc/sh/init.sh # buildkit

RUN rc-update add sshd
RUN rc-update add rsyslog

RUN mkdir /users

COPY files/create_users.start /etc/local.d

RUN rc-update add local

WORKDIR /

EXPOSE 22

ENTRYPOINT /sbin/init
