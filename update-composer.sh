#!/bin/sh

#EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
#php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
#
#if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
#then
#    >&2 echo 'ERROR: Invalid installer signature'
#    rm composer-setup.php
#    exit 1
#fi
#
#php composer-setup.php --quiet
#RESULT=$?
#rm composer-setup.php
#exit $RESULT

EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php self-update
RESULT=$?

mv -f composer.phar /usr/share/composer.phar
#ln -s /usr/share/composer.phar ./composer.phar
rm -f composer-setup.php update-composer.sh

php /usr/share/composer.phar self-update

exit $RESULT
