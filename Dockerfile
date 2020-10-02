# Dockerfile for python actions, overrides and extends ActionRunner from actionProxy
FROM openwhisk/dockerskeleton:1.14.0
FROM python:3.6

RUN apk add --no-cache \
        bzip2-dev \
        gcc \
        libc-dev \
        libxslt-dev \
        libxml2-dev \
        libffi-dev \
        linux-headers \
        openssl-dev

#COPY requirements.txt requirements.txt
#RUN pip3 install --upgrade pip six && pip3 install --no-cache-dir -r requirements.txt
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
 
ENV FLASK_PROXY_PORT 8080

RUN mkdir -p /pythonAction
ADD pythonrunner.py /pythonAction/
RUN rm -rf /action
RUN mkdir /action

CMD ["/bin/bash", "-c", "cd pythonAction && python -u pythonrunner.py"]
