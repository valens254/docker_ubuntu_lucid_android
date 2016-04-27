# docker Ubuntu 10.04 lucid Android OS build environment
#Use
docker pull igorsh/ubuntu10.04-android

docker run -it --rm -v /path/to/build/directory:/build -w /build igorsh/ubuntu10.04-android ./mk watch n
