setup:
	@docker compose up --build

up:
	@docker compose run --rm route53
	.bin/update.sh
	@docker compose up -d minecraft nginx certbot

down:
	.bin/stop.sh
	@docker compose run --rm backup
	.bin/renew_ssl_certificate.sh
	@docker compose down

logs:
	@docker compose logs minecraft

update:
	.bin/update.sh

backup:
	@docker compose run --rm backup

upload:
	.bin/upload.sh

route53:
	@docker compose run --rm route53

.PHONY: setup up down logs update backup upload route53
