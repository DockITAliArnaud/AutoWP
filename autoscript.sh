#!/bin/sh


# 14/06/2017 - Ali et Arnaud - Docker
# Sujet choisi:  Sujet 1
# Creation d'un script qui crée deux containers qui contiendront une version propre de Wordpress 
# Un container Apache, un container MySQL
# Utilisation wpcli (permet de faire une install de wordpress en ligne de commande)



#1-Installation de Docker
sudo apt-get update && apt-get -y install \
apt-transport-https \
ca-certificates \
curl \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu 
trusty \
stable" \ && sudo apt-get update
sudo apt-get -y install docker-ce
sudo usermod -a -G docker apprenant

#2-Creation du premier containeur mysql
docker run --name mysql -e MYSQL_ROOT_PASSWORD=P@SS3 -d mysql:latest
docker exec -t -i mysql /bin/bash
	apt-get update
	apt-get install mysql-server
	exit
		
#3-Creation du deuxième containeur 'apache' et liaison
docker run --name apache --link mysql -d httpd:latest
docker exec -t -i apache /bin/bash
	apt-get update
	apt-get install curl httpd libhttpd-mod-php5 libapache2-mod-php5 php5 php5-common php5-cli php5-curl php5-dev php5-gd php5-idn php-pear php5-imagick php5-imap php5-json php5-mcrypt php5-memcache php5-mhash php5-ming	php5-mysql 			php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

#4-Installation et configuration de WordPress

	apt-get install curl php5-cli
	cd /usr/local/apache2/htdocs/
	rm index.html
	curl -O https://wordpress.org/latest.tar.gz
	<DL DU DERNIER WORDPRESS..>
	tar -zxvf latest.tar.gz
	cd wordpress
	cp -rf . ..
	cd ..
	rm -R wordpress
	cp wp-config-sample.php wp-config.php
	perl -pi -e "s/database_name_here/wp_bdd/g" wp-config.php
	perl -pi -e "s/username_here/root/g" wp-config.php
	perl -pi -e "s/password_here/P@SS3/g" wp-config.php
	perl -i -pe'
		BEGIN {
		 @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
		 push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
		 sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
		}
	 s/Bienvenue sur votre site WordPress/salt()/ge
	 ' wp-config.php
	mkdir wp-content/uploads
	chmod 775 wp-content/uploads
	rm latest.tar.gz
	rm wp.sh
	exit
exit
