prod-build:
	docker build --pull --file=docker/prod/nginx/Dockerfile --tag ${REGISTRY_ADDRESS}/nginx:${IMAGE_TAG} app
	docker build --pull --file=docker/prod/php-cli/Dockerfile --tag ${REGISTRY_ADDRESS}/php-cli:${IMAGE_TAG} app
	docker build --pull --file=docker/prod/php-fpm/Dockerfile --tag ${REGISTRY_ADDRESS}/php-fpm:${IMAGE_TAG} app

prod-push:
	docker push ${REGISTRY_ADDRESS}/nginx:${IMAGE_TAG} app
	docker push ${REGISTRY_ADDRESS}/php-cli:${IMAGE_TAG} app
	docker push ${REGISTRY_ADDRESS}/php-fpm:${IMAGE_TAG} app

prod-deploy:
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'rm -rf docker-compose.yml .env'
	scp -P ${PRODUCTION_PORT} docker-compose-production.yml ${PRODUCTION_HOST}:docker-compose.yml
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'echo "REGISTRY_ADDRESS=${REGISTRY_ADDRESS}" >> .env'
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'echo "IMAGE_TAG=${IMAGE_TAG}" >> .env'
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'echo "MANAGER_APP_SECRET=${MANAGER_APP_SECRET}" >> .env'
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'echo "MANAGER_DB_PASSWORD=${MANAGER_DB_PASSWORD}" >> .env'
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'docker-compose pull'
	ssh ${PRODUCTION_HOST} -P ${PRODUCTION_PORT} 'docker-compose --build -d'

prod-cli:
	docker run --rm test-lamp-img php bin/index.php

docker-up:
	docker-compose up --build -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

app-composer-install:
	docker-compose run --rm dev-php-cli composer install

app-init: app-composer-install

up: docker-up
init: docker-down-clear docker-pull docker-build docker-up app-init
