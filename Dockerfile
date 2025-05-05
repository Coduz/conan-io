FROM rockylinux:9

COPY tutorial/consuming_packages/simple_cmake_project example_project

RUN dnf install -y cmake python3-pip
RUN pip3 install conan

WORKDIR /example_project

RUN conan profile detect
RUN conan profile show

RUN conan install . --output-folder=build --build=missing

