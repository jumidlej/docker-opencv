# raspbian
FROM raspbian/stretch
# será que já tem python? se não tem que instalar
# disse que a versão desktop já tem...
# stretch é versão lite

USER root
WORKDIR /

# liberar espaço
RUN apt-get clean && apt-get autoremove

# pre-requisitos
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y python3 \
    build-essential \
    cmake \ 
    pkg-config \
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

# RUN apt-get install -y libhdf5-dev libhdf5-serial-dev libhdf5-103
# RUN apt-get install -y libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
RUN apt-get install -y python3-dev

# instalar pip
ADD https://bootstrap.pypa.io/get-pip.py /get-pip.py
# será que precisa desse comando? só instalei o python3
# RUN python get-pip.py
RUN python3 get-pip.py
RUN rm -rf ~/.cache/pip

# instalar picamera
RUN pip --version
# RUN pip3 --version
RUN pip install "picamera[array]"
RUN pip install numpy

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
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
    -D BUILD_EXAMPLES=OFF \ 
    .. \
&& make -j4 \
&& make install \
&& ldconfig

CMD ["python3", "app.py"]

