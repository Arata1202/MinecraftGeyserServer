build:
	@docker compose build

up:
	@docker compose up -d

down:
	.bin/stop.sh
	@docker compose down

logs:
	@docker compose logs minecraft

.PHONY: build up down logs
