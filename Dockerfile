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
  apt-get install --yes python-pip
  # sudo pip install lit && \
  # sudo pip install OutputCheck

# Install llvm and z3 into /root/llvm-z3-run
WORKDIR /root
RUN \
  mkdir llvm-z3-run && \
  git clone --depth 1 --branch llvmorg-3.6.0 https://github.com/llvm/llvm-project.git && \
  cd llvm-project/llvm && \
  mkdir build && \
  cd build && \
  cmake -DCMAKE_INSTALL_PREFIX:PATH=/root/llvm-z3-run -DLLVM_REQUIRES_RTTI:BOOL=TRUE .. && \
  cmake --build . --target install -- -j && \
  cd /root && \
  git clone https://bitbucket.org/spacer/code.git && \
  cd code && \
  python scripts/mk_make.py --prefix=/root/llvm-z3-run && \
  cd build && \
  make -j && \
  make install && \
  cd /root && \
  rm -rf llvm-project/ z3/


# Install LinearArbitrary-SeaHorn


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
