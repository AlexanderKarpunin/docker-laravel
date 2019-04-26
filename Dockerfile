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

#EXPOSE 80

RUN rm -f /var/www/html/index.html
COPY index.php /var/www/html/

CMD ["/bin/su", "-l", "alto"]
