# Copyright (C) 2015-2016 Intel Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

FROM crops/yocto:ubuntu-14.04-base

USER root

ENV LANG=en_US.UTF-8

RUN userdel -r yoctouser

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/yoctouser && \
    echo "yoctouser:x:${uid}:${gid}:yoctouser,,,:/home/yoctouser:/bin/bash" >> /etc/passwd && \
    echo "yoctouser:x:${uid}:" >> /etc/group && \
    echo "yoctouser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/yoctouser && \
    chmod 0440 /etc/sudoers.d/yoctouser && \
    chown ${uid}:${gid} -R /home/yoctouser


RUN apt-get install -y vim ack-grep bash curl wget
COPY .bashrc  /home/yoctouser/.bashrc
COPY .profile /home/yoctouser/.profile
RUN chown yoctouser:yoctouser -R /home/yoctouser
RUN ln -sf /bin/bash /bin/sh

USER yoctouser
ENV HOME /home/yoctouser
WORKDIR $HOME


CMD /bin/bash
