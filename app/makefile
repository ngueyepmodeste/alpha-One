.PHONY: build start stop restart database fix-permissions

build:
	docker-compose build

start: build
	docker-compose up --detach
	make fix-permissions

stop:
	docker-compose down --remove-orphans --volumes --timeout 0

restart: stop start

database:
	docker-compose exec mariadb sh -c 'mysql --user=$$DATABASE_USER --password=$$DATABASE_PASSWORD $$DATABASE_NAME'

fix-permissions:
	docker-compose exec php sh -c 'chown -R php:php /home/php/uploads && chmod -R 775 /home/php/uploads'
