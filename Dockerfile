# raspbian
FROM raspbian/desktop
# será que já tem python? se não tem que instalar
# disse que a versão desktop já tem...

WORKDIR /
USER root

# liberar espaço
RUN apt-get clean
RUN apt-get autoremove

# instalar python3
# RUN apt-get update
# RUN apt install python3 idle3

# pre-requisitos
RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y build-essential \
    cmake pkg-config \
    libjpeg-dev \
    libtiff5-dev \
    libjasper-dev \
    libpng-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libfontconfig1-dev \
    libcairo2-dev \
    libgdk-pixbuf2.0-dev \
    libpango1.0-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran

# instalar pip
# não consegui fazer com o wget, tive que pegar o arquivo
ADD https://bootstrap.pypa.io/get-pip.py /get-pip.py
# não tem o get-pip.py
# será que precisa desse comando? só instalei o python3
# COPY get-pip.py /get-pip.py
# RUN python get-pip.py
RUN python3 get-pip.py
RUN rm -rf ~/.cache/pip

# instalar picamera
# não tá conseguindo instalar coisas com o Pip
# Erro na instalação do numpy: Tinha que instalar o python3-dev antes
RUN apt-get install -y python3-dev
RUN pip install "picamera[array]"
# picamera já instala o numpy tbm, mas sla, vou deixar aqui
RUN pip install numpy

# instalar opencv
# RUN cd ~
# ADD https://github.com/opencv/opencv/archive/4.1.1.zip /opencv
# ADD https://github.com/opencv/opencv_contrib/archive/4.1.1.zip /opencv_contrib
# ADD já descomprime e eu acho que a gente já pode colocar na pasta com o nome certo
# RUN unzip opencv.zip
# RUN unzip opencv_contrib.zip
# RUN mv opencv-4.1.1 opencv
# RUN mv opencv_contrib-4.1.1 opencv_contrib

RUN apt-get install -y unzip
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip \
&& wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip \
&& unzip opencv.zip \
&& unzip opencv_contrib.zip \
&& mv opencv-4.1.1 opencv \
&& mv opencv_contrib-4.1.1 opencv_contrib \
&& cd /opencv \
&& mkdir build \
&& cd build \
&& cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
    -D BUILD_EXAMPLES=OFF .. \
&& make -j4 \
&& make install \
&& ldconfig

# RUN cd opencv
# RUN mkdir /opencv/build
# RUN cd build
# RUN /opencv/build/cmake -D CMAKE_BUILD_TYPE=RELEASE \
#    -D CMAKE_INSTALL_PREFIX=/usr/local \
#    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
#    -D ENABLE_NEON=ON \
#    -D ENABLE_VFPV3=ON \
#    -D BUILD_TESTS=OFF \
#    -D INSTALL_PYTHON_EXAMPLES=OFF \
#    -D OPENCV_ENABLE_NONFREE=ON \
#    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
#    -D BUILD_EXAMPLES=OFF ..

# RUN /opencv/build/make -j4
# RUN /opencv/build/make install
# RUN /opencv/build/ldconfig