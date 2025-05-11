setup:
	@docker compose up --build

up:
	@docker compose up -d

down:
	@mcrcon -H 127.0.0.1 -P 25575 -p minecraft stop
	@while pgrep -f "java.*Paper.jar" > /dev/null; do \
		sleep 1; \
	done
	@docker compose down

logs:
	@docker compose logs minecraft

.PHONY: build up down logs
