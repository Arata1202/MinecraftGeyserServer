setup:
	@docker compose up --build

up:
	@docker compose up -d

logs:
	@docker compose logs minecraft

stop:
	.bin/stop.sh

.PHONY: setup up logs stop
