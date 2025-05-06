chmod:
	@chmod +x .docker/*.sh
	@chmod +x .bin/*.sh
	@chmod +x .bin/edit/*.sh
	@chmod +x .bin/edit/cmd/*.sh
	@chmod +x .bin/jar/*.sh
	@chmod +x .bin/jar/cmd/*.sh
	@chmod +x .bin/mv/*.sh
	@chmod +x .bin/mv/cmd/*.sh

setup: chmod
	@docker compose up --build

up:
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

init:
	@cd .terraform
	@terraform init
	@cd ..

plan:
	@cd .terraform
	@terraform plan
	@cd ..

apply:
	@cd .terraform
	@terraform apply
	@cd ..

.PHONY: chmod up reboot boot jar edit mv init plan apply
