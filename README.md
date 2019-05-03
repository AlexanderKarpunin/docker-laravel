# docker-test

git clone -b 04 https://github.com/AlexanderKarpunin/docker-test.git

docker build --no-cache -t shakra/docker-test docker-test

docker run -p 127.0.0.1:80:80 -p 127.0.0.1:8000:8000 -p 127.0.0.1:137:137/udp -p 127.0.0.1:138:138/udp -p 127.0.0.1:139:139 -p 127.0.0.1:445:445 --rm -it shakra/docker-test
