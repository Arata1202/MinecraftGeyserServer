setup:
	@docker compose up --build

up:
	@docker compose up -d

down:
	.bin/stop.sh
	.bin/backup.sh
	@docker compose down

logs:
	@docker compose logs minecraft

update:
	.bin/update.sh

backup:
	.bin/backup.sh

.PHONY: build up down logs update backup
