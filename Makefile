default:
	@echo "make up|stop|start|restart|down|build|php"
	@echo up: start the containers
	@echo down: stop the containers
	@echo "php: enter in php-fpm container (/var/www/sites <=> SCRIPTS in .ENV file)"

build:
	docker-compose build

up:
	docker-compose up -d

stop:
	docker-compose stop

start:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose stop
	docker-compose start

php:
	docker-compose exec --user www-data php bash
