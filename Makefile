chmod:
	@chmod +x .docker/*.sh
	@chmod +x .bin/*.sh
	@chmod +x .bin/jar/*.sh
	@chmod +x .bin/edit/*.sh
	@chmod +x .bin/mv/*.sh
	@chmod +x .bin/stop/*.sh

up:
	@docker compose up --build

reboot:
	.bin/reboot.sh

boot:
	.bin/boot.sh

jar:
	.bin/jar/floodgate.sh
	.bin/jar/geyser.sh
	.bin/jar/paper.sh
	.bin/jar/via-version.sh

edit:
	.bin/edit/eula.sh
	.bin/edit/geyser-spigot.sh
	.bin/edit/server-properties.sh

mv:
	.bin/mv/jar.sh

stop:
	.bin/stop/server.sh

.PHONY: chmod up reboot boot jar edit mv stop
