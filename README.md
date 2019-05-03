# docker-laravel

git clone -b 04 https://github.com/AlexanderKarpunin/docker-laravel.git

docker build --no-cache -t shakra/docker-laravel docker-laravel

docker run -p 127.0.0.1:80:80 -p 127.0.0.1:8000:8000 -p 127.0.0.1:137:137/udp -p 127.0.0.1:138:138/udp -p 127.0.0.1:139:139 -p 127.0.0.1:445:445 --rm -it shakra/docker-laravel

mkdir ~/laravel

sudo mount -t cifs //127.0.0.1/alto ~/laravel -o users,username=alto,password="12345"

cd ~/laravel
