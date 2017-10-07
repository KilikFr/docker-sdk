Kilik Docker SDK
================

Installation instructions to build containers with: nginx php-fpm memcached mysql

requirements:

	docker
	git
	make

install requirements
--------------------
```shell
sudo apt-get install git Make
```

install docker on debian
------------------------

```shell
sudo apt-get update

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     git \
     software-properties-common \
     make

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" 

sudo apt-get update

sudo apt-get install docker-ce

sudo docker run -d -p 9900:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
```

You can now access portainer: http://localhost:9900/


install kilik docker sdk
------------------------
 
commands:

	cd ~
	git clone git@github.com:kilik/docker-sdk.git docker-sdk

setup your default env (file .env, replace kilik by your login):

```
// .env file
MYSQL_ROOT_PASSWORD=test
MYSQL_DATABASE=test
MYSQL_USER=test
MYSQL_PASSWORD=test
SCRIPTS=/home/kilik/PhpstormProjects
LOGIN=kilik
HOMEDIR=/home/kilik
UID=1000
GID=1000
```

add some virtual hosts into sites-enabled:
```
cp sites.enabled.dist/example.conf sites.enabled/
```

or create a similar file:

```
# example.conf (symfony project)
server {
    server_name example.dev;
    root /var/www/sites/example.dev/web;
 
    location / {
        try_files $uri @rewriteapp;
    }
 
    location @rewriteapp {
        rewrite ^(.*)$ /app.php/$1 last;
    }
 
    location ~ ^/(app|app_dev|app_test|config)\.php(/|$) {
        fastcgi_pass php-upstream;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param HTTPS off;
    }

    error_log /var/log/nginx/example_error.log;
    access_log /var/log/nginx/example_access.log;
}
```

then, build images:

```
sudo make build
sudo make up
```

create your first symfony application:
```
sudo make php
# now in container
symfony new example.dev
exit
# now in host
# add host
echo "127.0.0.1 example.dev" | sudo tee --append /etc/hosts
# restart front container (nginx) to reload vhosts config
sudo make restart
```

Now, you can access your new symfony application and phpmyadmin:
- phpmyadmin: http://localhost:81/ (root:test), check your .ENV file
- example: http://example.dev/
