setup:
	@docker compose up --build

up:
	@docker compose up -d

down:
	.bin/stop.sh
	@docker compose down

logs:
	@docker compose logs minecraft

update:
	.bin/update.sh

.PHONY: build up down logs update
