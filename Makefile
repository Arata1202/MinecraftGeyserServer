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

upload:
	.bin/upload.sh

.PHONY: setup up down logs update backup upload
