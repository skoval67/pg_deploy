include .env

.PHONY: all

all: run_playbook

prepare: build_infra venv_init

venv_init:
	@cd ansible; \
		python3 -m venv .venv; \
        . .venv/bin/activate; \
        pip install -r requirements.txt

build_infra:
	@cd terraform;\
		export TF_VAR_MY_IP="$$(curl -s https://ident.me)/32";\
		terraform apply -auto-approve

run_playbook:
	@cd terraform;\
		export inventory="$$(terraform output -json | jq -r .[].value | xargs | sed -e 's/ /,/g')";\
	cd ../ansible;\
		. .venv/bin/activate;\
		ansible-playbook -b -e DB_HOST="158.160.94.74" -e CLIENT_HOST="158.160.108.169/32" -e postgres_password=${POSTGRESS_PASSWORD} -i $${inventory}, playbook.yml
