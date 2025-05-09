chmod:
	@chmod +x .docker/*.sh
	@chmod +x .bin/*.sh
	@chmod +x .bin/edit/*.sh
	@chmod +x .bin/edit/cmd/*.sh
	@chmod +x .bin/jar/*.sh
	@chmod +x .bin/jar/cmd/*.sh
	@chmod +x .bin/mv/*.sh
	@chmod +x .bin/mv/cmd/*.sh

run:
	@screen -dmS minecraft java -Xmx2G -Xms2G -jar Paper.jar

screen:
	@screen -r minecraft

setup: chmod
	@.aws/chmod.sh
	@docker compose up --build

up:
	@.aws/chmod.sh
	@docker compose up

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

.PHONY: chmod run screen up reboot boot jar edit mv
