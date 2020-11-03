FROM centos:8

 

ARG NAME
ENV NAME "$NAME"

ENV master_IP
 

ENV SALT_VERSION=3000.3

 
#RUN gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Official
RUN yum -y update && yum -y install sudo curl dirmngr gnupg net-tools wget && yum -y install https://repo.saltstack.com/py3/redhat/salt-py3-repo-3000.el8.noarch.rpm

 

# install salt-minion
RUN yum -y update && yum -y install salt-minion 
RUN rpm -qa | grep salt- 
  
 

# copy the minion configuration
COPY ./minion.conf /etc/salt/minion.d/
RUN echo "root  ALL=(ALL:ALL) NOPASSWD:ALL\nsudo_usuario ALL=(root:root) NOPASSWD: /usr/bin/salt-call" >/etc/sudoers

 

# define main container command
CMD echo  "`ip route get 1.1.1.1 | sed -ne '/src/s/.*via *\([^ ]*\).*/\1/p'`     saltmaster">>/etc/hosts && echo "master: $master_IP" > /etc/salt/minion.d/minion.conf && /usr/bin/salt-minion -l debug 
