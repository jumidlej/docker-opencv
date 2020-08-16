# docker-opencv
Imagem Docker com OpenCV 4 para Raspberry Pi

* Diferença entre ADD e COPY
* WORKDIR
* Dá pra navegar por diretórios em um Dockerfile? Como?

# Dockerfile
* Erro na instalação do numpy
Precisa instalar o python3-dev primeiro pra rodar o pip install numpy
* Erros no cmake:
Could NOT find PythonLibs (missing:  PYTHON_LIBRARIES PYTHON_INCLUDE_DIRS) (Required is exact version "2.7.13")
Traceback (most recent call last):
 File "<string>", line 1, in <module>
ImportError: No module named numpy.distutil

CMake Error at cmake/OpenCVModule.cmake:289 (message):
 No modules has been found: /root/opencv_contrib/modules
Call Stack (most recent call first):
 cmake/OpenCVModule.cmake:371 (_glob_locations)
 modules/CMakeLists.txt:7 (ocv_glob_modules)

Verificar: Se estamos usando o python certo
Fazer Dockerfile com e sem ambiente virtual