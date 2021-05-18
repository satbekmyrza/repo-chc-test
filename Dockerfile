# Dockerfile for Seahorn

# OS image
FROM ubuntu:14.04

MAINTAINER Satbek Abdyldayev <satbek@unist.ac.kr>

# Set up openssh-server
RUN \
  apt-get update && \
  apt-get install -y openssh-server && \
  mkdir /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
  mkdir /root/.ssh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install
RUN \
  sudo apt-get update -qq && \
  sudo apt-get upgrade -qq && \
  sudo apt-get install bridge-utils && \
  apt-get install -qq build-essential clang-3.6 && \
  apt-get install -qq software-properties-common && \
  apt-get install -qq curl git ninja-build man subversion vim wget cmake && \
  apt-get install -qq libboost-program-options-dev && \
  apt-get install python2.7 python2.7-dev -y && \
  apt-get install -y libboost1.55-all-dev && \
  apt-get install --yes libgmp-dev && \
  apt-get install --yes python-pip && \
  # sudo pip install lit && \
  sudo pip install OutputCheck

# Install llvm and z3


# Install LinearArbitrary-SeaHorn


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
