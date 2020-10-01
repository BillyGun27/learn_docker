FROM python:3.6

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
