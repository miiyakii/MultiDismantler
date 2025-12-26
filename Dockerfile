# hash:sha256:caf6493bf0fd996952ced7e6712783664b5b5fd0ef5169205eb8548fefeb605c
# FROM registry.codeocean.com/codeocean/miniconda3:4.9.2-cuda11.7.0-cudnn8-ubuntu20.04

# ARG DEBIAN_FRONTEND=noninteractive
FROM nvidia/cuda:11.7.0-cudnn8-runtime-ubuntu20.04

# 安装 Miniconda
RUN apt-get update && apt-get install -y wget && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda clean -a

ENV PATH="/opt/conda/bin:${PATH}"

ARG DEBIAN_FRONTEND=noninteractive
RUN pip3 install -U --no-cache-dir \
    networkx==2.5.1

COPY postInstall /
RUN chmod +x /postInstall && /postInstall