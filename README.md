# docker-test

git https://github.com/AlexanderKarpunin/docker-test.git
docker build -t shakra/alt_apache_laravel ~/docker-test
docker run -p 127.0.0.1:80:80 --rm -it shakra/alt_apache_laravel
