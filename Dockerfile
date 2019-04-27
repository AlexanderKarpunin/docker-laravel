# Version: 0.0.1
FROM alt:sisyphus
MAINTAINER Alexander Karpunin <ak@shakra.ru>
RUN apt-get update

RUN apt-get install -y mc glibc-locales startup passwd su sudo

RUN echo LANG=ru_RU.UTF-8 > /etc/sysconfig/i18n
RUN echo SUPPORTED=ru_RU.UTF-8 >> /etc/sysconfig/i18n

RUN echo "root:0123456789" | chpasswd
RUN adduser -G wheel -m -r alto
RUN echo "alto:12345" | chpasswd
RUN echo "WHEEL_USERS ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get install -y apache2-full
RUN mkdir /var/lock/subsys
RUN mkfifo /dev/initctl

RUN apt-get install -y apache2-mod_php7
RUN apt-get install -y php7-openssl php7-pdo php7-mbstring git-core wget composer php7-zip unzip php7-dom

#RUN sudo wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet
COPY update-composer.sh /home/alto/
RUN chmod u+x /home/alto/update-composer.sh
RUN /home/alto/./update-composer.sh
RUN rm -f /home/alto/./update-composer.sh

EXPOSE 8000

#RUN su -l -c "composer global require \"laravel/lumen-installer\"" -s "/bin/sh" alto
#RUN echo "export PATH=\"$PATH:/home/alto/.composer/vendor/bin\"" >> /home/alto/.bashrc

RUN su -l -c "composer create-project --prefer-dist laravel/lumen blog" -s "/bin/sh" alto

RUN rm -f /var/www/html/index.html
COPY index.php /var/www/html/

CMD ["/bin/su", "-l", "alto"]
