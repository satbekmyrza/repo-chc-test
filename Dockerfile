# Dockerfile for Seahorn

# OS image
FROM ubuntu:14.04

MAINTAINER Satbek Abdyldayev <satbek@unist.ac.kr>

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

# Install llvm and z3

# Install LinearArbitrary-SeaHorn
