setup:
	@docker compose up --build

up:
	@docker compose run --rm route53
	.bin/update.sh
	@docker compose up -d minecraft nginx cron

down:
	.bin/stop.sh
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

active:
	.bin/active.sh

stop:
	.bin/stop.sh

update:
	.bin/update.sh

upload:
	.bin/upload.sh

.PHONY: setup up down backup batch certbot route53 active stop update upload
