# docker-test

git clone -b 03 https://github.com/AlexanderKarpunin/docker-test.git

docker build --no-cache -t shakra/docker-test docker-test

docker run -p 127.0.0.1:80:80 --rm -it shakra/docker-test
