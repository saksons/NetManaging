# Здесь описать terraform
# ansible

TF_PATH=./terraform
TF_FLAGS=-auto-approve
ANSIBLE_PATH=./ansible

all: up

# build:
# python, minicom, terraform, jq

up: tf-up prepare-configs ansible-up

destroy: tf-destroy remove-configs

restart: destroy up

tf-up:
	cd $(TF_PATH) && terraform apply $(TF_FLAGS)

tf-destroy:
	cd $(TF_PATH) && terraform destroy $(TF_FLAGS)

prepare-configs:
	cd $(TF_PATH) && bash console.sh
	chmod 0600 $(TF_PATH)/creds/private_key.pem
	cp -r $(TF_PATH)/creds $(ANSIBLE_PATH)/creds
	cp -r $(TF_PATH)/outputs/mikrotik.pass $(ANSIBLE_PATH)/creds/mikrotik.pass
	export $$(jq -r 'to_entries|map("\(.key)=\(.value)").[]' $(ANSIBLE_PATH)/creds/mikrotik.pass) && \
	export $$(cat .env | grep MIKROTIK_ADDRESS | tr '[:upper:]' '[:lower:]' | tr -d '"' | xargs ) && \
	envsubst < $(ANSIBLE_PATH)/hosts.template > $(ANSIBLE_PATH)/hosts
	nft -f $(ANSIBLE_PATH)/creds/nftables.conf

remove-configs:
	rm -rf $(TF_PATH)/creds $(TF_PATH)/outputs $(ANSIBLE_PATH)/creds $(ANSIBLE_PATH)/hosts

ansible-up:
	cd $(ANSIBLE_PATH) && ansible-playbook main.yml

ansible-check:
	cd $(ANSIBLE_PATH) && ansible ARCH -m ping