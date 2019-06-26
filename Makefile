dev-up:
	sudo docker run -d --name test-apache-img -v ${PWD}/app:/app -p 8080:80 test-apache-img

dev-down:
	sudo docker stop test-apache-img
	sudo docker rmi test-apache-img

dev-build:
	sudo docker build --file=docker/dev/php-cli/Dockerfile --tag test-php-img app
	sudo docker build --file=docker/dev/apache/Dockerfile --tag test-apache-img app

dev-cli:
	sudo docker run --rm -v ${PWD}/app:/app php bin/index.php

prod-up:
	sudo docker run -d --name test-apache-img -p 8080:80 test-apache-img

prod-down:
	sudo docker stop test-apache-img
	sudo rmi test-apache-img

prod-build:
	sudo docker build --file=docker/prod/php-cli/Dockerfile --tag ${REGISTRY_ADDRESS}/test-php-img:${IMAGE_TAG} app
	sudo docker build --file=docker/prod/apache/Dockerfile --tag ${REGISTRY_ADDRESS}/test-apache-img:${IMAGE_TAG} app

prod-push:
	sudo docker push ${REGISTRY_ADDRESS}/test-php-img:${IMAGE_TAG} app
	sudo docker push ${REGISTRY_ADDRESS}/test-apache-img:${IMAGE_TAG} app

prod-cli:
	sudo docker run --rm test-lamp-img php bin/index.php

docker-up:
	sudo docker-compose up --build -d

docker-down:
	sudo docker-compose down --remove-orphans

docker-down-clear:
	sudo docker-compose down -v --remove-orphans

docker-pull:
	sudo docker-compose pull

docker-build:
	sudo docker-compose build

up: docker-up
init: docker-down-clear docker-pull docker-build docker-up
