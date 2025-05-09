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

stop:
	@screen -S minecraft -X stuff "/stop$(echo \r)"

setup: chmod
	@docker compose up --build

up:
	@docker compose up

reboot:
	.bin/reboot.sh

boot:
	.bin/boot.sh

git:
	.bin/git.sh

jar:
	.bin/jar/entrypoint.sh

edit:
	.bin/edit/entrypoint.sh

mv:
	.bin/mv/entrypoint.sh

ec2:
	.aws/ec2.sh

.PHONY: chmod run stop up reboot boot git jar edit mv ec2
