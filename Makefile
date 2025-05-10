setup:
	@.aws/chown.sh
	@docker compose up --build

up:
	@.aws/chown.sh
	@docker compose up -d

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

.PHONY: up reboot boot jar edit mv
