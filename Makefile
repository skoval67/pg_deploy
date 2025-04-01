SHELL := /bin/bash

include .env

.PHONY: all

all: inv

prepare: venv_init build_infra

venv_init:
	@cd ansible; \
		python3 -m venv .venv; \
        . .venv/bin/activate; \
        pip install -r requirements.txt

build_infra:
	@cd terraform;\
		export TF_VAR_MY_IP="$$(curl -s https://ident.me)/32";\
		terraform apply -auto-approve

inv:
	@cd terraform;\
		export inventory="$$(terraform output -json | jq -r .[].value | xargs | sed -e 's/ /,/g')";\
		cd ..; $(MAKE) pg_deploy

pg_deploy:
	@cd ansible;\
		. .venv/bin/activate;\
		targets=( $$(./check_la15 $${inventory}) );\
		ansible-playbook -b -e DB_HOST="$${targets[0]}" -e CLIENT_HOST="$${targets[1]}/32" -e postgres_password=${POSTGRESS_PASSWORD} -i $${inventory}, playbook.yml
