# Version: 0.0.1
FROM alt

MAINTAINER Alexander Karpunin <ak@shakra.ru>
RUN apt-get update

RUN apt-get install -y mc glibc-locales startup passwd su sudo

RUN echo LANG=ru_RU.UTF-8 > /etc/sysconfig/i18n
RUN echo SUPPORTED=ru_RU.UTF-8 >> /etc/sysconfig/i18n

RUN echo "root:0123456789" | chpasswd
RUN adduser -G wheel -m -r alto
RUN usermod -u 500 alto
RUN echo "alto:12345" | chpasswd
RUN echo "WHEEL_USERS ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get install -y apache2-full
RUN mkfifo /dev/initctl

RUN apt-get install -y apache2-mod_php7
RUN apt-get install -y php7-openssl php7-pdo php7-pdo_mysql php7-mbstring git-core wget composer php7-zip unzip php7-dom

COPY update-composer.sh /home/alto/
RUN chmod u+x /home/alto/update-composer.sh
RUN /home/alto/./update-composer.sh
RUN rm -f /home/alto/./update-composer.sh

RUN su -l -c "composer create-project --prefer-dist laravel/laravel blog" -s "/bin/sh" alto

RUN rm -f /etc/httpd2/conf/sites-available/default.conf
COPY default.conf /etc/httpd2/conf/sites-available/

RUN gpasswd -a alto webmaster
RUN gpasswd -a alto apache2
RUN gpasswd -a apache2 webmaster
RUN chown -R alto:webmaster /home/alto/blog
RUN find /home/alto/ -type d -exec chmod 775 {} \;

EXPOSE 80
EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 139
EXPOSE 445

RUN apt-get install -y samba
RUN rm -f /etc/samba/smb.conf
COPY smb.conf /etc/samba/
RUN (echo "12345"; echo "12345") | smbpasswd -as alto
RUN smbpasswd -e alto

RUN echo "sudo rm -f /var/run/httpd2/httpd.pid" >> /home/alto/.bashrc
RUN echo "sudo rm -f /var/run/smbd.pid" >> /home/alto/.bashrc
RUN echo "sudo service httpd2 restart" >> /home/alto/.bashrc
RUN echo "sudo service smb restart" >> /home/alto/.bashrc

CMD ["/bin/su", "-l", "alto"]

