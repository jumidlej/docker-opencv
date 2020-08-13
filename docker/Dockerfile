# raspbian
FROM raspbian/desktop
# será que já tem python? se não tem que instalar

USER root

# liberar espaço
RUN apt-get clean
RUN apt-get autoremove

# instalar python3
# RUN apt-get update
# RUN apt install python3 idle3

# pre-requisitos
RUN apt-get update 
RUN apt-get upgrade
RUN apt-get install -y build-essential cmake pkg-config
RUN apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
RUN apt-get install -y libxvidcore-dev libx264-dev
RUN apt-get install -y libfontconfig1-dev libcairo2-dev
RUN apt-get install -y libgdk-pixbuf2.0-dev libpango1.0-dev
RUN apt-get install -y libgtk2.0-dev libgtk-3-dev
RUN apt-get install -y libatlas-base-dev gfortran

# instalar pip
RUN wget https://bootstrap.pypa.io/get-pip.py
# será que precisa desse comando? só instalei o python3
RUN python get-pip.py
RUN python3 get-pip.py
RUN rm -rf ~/.cache/pip

# instalar picamera
RUN pip install "picamera[array]"

# instalar opencv
RUN cd ~
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip
RUN unzip opencv.zip
RUN unzip opencv_contrib.zip
RUN mv opencv-4.1.1 opencv
RUN mv opencv_contrib-4.1.1 opencv_contrib

RUN pip install numpy

RUN cd ~/opencv
RUN mkdir build
RUN cd build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D CMAKE_SHARED_LINKER_FLAGS=-latomic \
    -D BUILD_EXAMPLES=OFF ..

RUN make -j4
RUN make install
RUN ldconfig