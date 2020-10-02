# Dockerfile for python AI actions, overrides and extends ActionRunner from actionProxy
FROM tensorflow/tensorflow:1.11.0-py3
FROM python:3.6

ENV FLASK_PROXY_PORT 8080
ENV PYTHONIOENCODING "UTF-8"

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        gcc \
        libc-dev \
        libxslt-dev \
        libxml2-dev \
        libffi-dev \
        libssl-dev \
        zip \
        unzip \
        vim \
        && rm -rf /var/lib/apt/lists/*

RUN apt-cache search linux-headers-generic

RUN curl -L https://downloads.rclone.org/rclone-current-linux-amd64.deb -o rclone.deb \
    && dpkg -i rclone.deb \
    && rm rclone.deb
    
#COPY requirements.txt requirements.txt
#RUN pip3 install --upgrade pip six && pip3 install --no-cache-dir -r requirements.txt

RUN pip3 install --upgrade pip six

RUN pip install --upgrade pip && \
    pip install minio && \
    pip install pyyaml && \
    pip install inflect==3.0.2 && \
    pip install librosa==0.7.2 && \
    pip install matplotlib==3.0.3 && \
    pip install numpy==1.18.1 && \
    pip install Pillow==7.0.0 && \
    pip install scipy==1.4.1 && \
    pip install tensorboardX==2.0 && \
    pip install tensorflow==1.13.1 && \
    pip install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html && \
    pip install Unidecode==1.1.1
 
RUN mkdir -p /actionProxy
ADD https://raw.githubusercontent.com/apache/openwhisk-runtime-docker/dockerskeleton%401.3.3/core/actionProxy/actionproxy.py /actionProxy/actionproxy.py

RUN mkdir -p /pythonAction
COPY pythonrunner.py /pythonAction/pythonrunner.py

CMD ["/bin/bash", "-c", "cd /pythonAction && python -u pythonrunner.py"]
