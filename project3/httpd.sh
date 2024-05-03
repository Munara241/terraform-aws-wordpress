#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
# cd /var/www/html
# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# cp -r wordpress/* .
# rm -rf wordpress latest.tar.gz

yum install epel-release mysql -y
yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum-config-manager --enable remi-php74
yum install php php-mysql -y
mv wordpress/*  /var/www/html
chown -R apache:apache /var/www/html
rm -rf /var/www/html/index.html
