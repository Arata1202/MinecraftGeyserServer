setup:
	@docker compose up --build

up:
	@docker compose up -d

logs:
	@docker compose logs minecraft

reboot:
	.bin/reboot.sh

boot:
	.bin/boot.sh

jar:
	.bin/jar/entrypoint.sh

edit:
	.bin/edit/entrypoint.sh

mv:
	.bin/mv/entrypoint.sh

.PHONY: setup up logs reboot boot jar edit mv
