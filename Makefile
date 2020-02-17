
TF_EXEC = terraform

TF_FILE = 

init:
	cd infra && $(TF_EXEC) init

destroy:
	cd infra && $(TF_EXEC) destroy

build:
	cd infra && $(TF_EXEC) apply -auto-approve

rebuild_all: destroy build
