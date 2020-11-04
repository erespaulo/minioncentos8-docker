FROM centos:8



ARG NAME
ENV NAME "$NAME"


ENV SALT_VERSION=3000.3

ARG master_IP

#RUN gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official
RUN yum -y update && yum -y install sudo curl dirmngr gnupg net-tools wget && yum -y install https://repo.saltstack.com/py3/redhat/salt-py3-repo-3000.el8.noarch.rpm



# install salt-minion
RUN yum -y update && yum -y install salt-minion
RUN rpm -qa | grep salt-



# copy the minion configuration
RUN echo "root  ALL=(ALL:ALL) NOPASSWD:ALL\nsudo_paulo ALL=(root:root) NOPASSWD: /usr/bin/salt-call" >/etc/sudoers
RUN echo "master: $master_IP" > /etc/salt/minion.d/minion.conf


# define main container command
CMD echo  "`ip route get 1.1.1.1 | sed -ne '/src/s/.*via *\([^ ]*\).*/\1/p'` saltmaster">>/etc/hosts && /usr/bin/salt-minion
