setup:
	@docker compose up --build

up:
	@docker compose run --rm route53
	scripts/update.sh
	@docker compose up -d minecraft nginx

down:
	scripts/stop.sh
	@docker compose run --rm backup
	@docker compose run --rm certbot renew
	@docker compose down

backup:
	@docker compose run --rm backup

batch:
	@docker compose run --rm batch

certbot:
	@docker compose run --rm certbot renew

route53:
	@docker compose run --rm route53

cron:
	scripts/cron.sh

stop:
	scripts/stop.sh

update:
	scripts/update.sh

upload:
	scripts/upload.sh

.PHONY: setup up down backup batch certbot route53 cron stop update upload
