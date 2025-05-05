FROM rockylinux:9

COPY tutorial/consuming_packages/simple_cmake_project example_project

RUN dnf groupinstall -y 'Development Tools'
RUN dnf install -y cmake python3-pip
RUN pip3 install conan

WORKDIR /example_project

RUN conan profile detect
RUN conan profile show

RUN conan install . --output-folder=build --build=missing

WORKDIR /example_project/build

RUN cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
RUN cmake --build .
