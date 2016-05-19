# docker Ubuntu 10.04 lucid Android OS build environment
#Use
[Install Docker](https://docs.docker.com/linux/step_one/)

docker pull igorsh/ubuntu10.04-android

docker run -it --rm -v "$PWD":/build -w /build igorsh/ubuntu10.04-android
