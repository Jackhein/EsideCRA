
TF_EXEC = terraform

TF_FILE = 

TF_PWD_LINK = "https://releases.hashicorp.com/terraform-provider-random/2.2.1/"$(TF_PWD_ZIP)

TF_PWD_ZIP = "terraform-provider-random_2.2.1_linux_amd64.zip"

zip_lambda:
	mkdir -p dist
	cd dist && rm -f *.zip && zip -jr lambda_get_data.zip ../lambda/lambda_get_data/*

init:
	wget $(TF_PWD_LINK)
	unzip -o $(TF_PWD_ZIP) -d infra/
	rm $(TF_PWD_ZIP)
	cd infra && $(TF_EXEC) init

destroy:
	cd infra && $(TF_EXEC) destroy

build:
	cd infra && $(TF_EXEC) apply -auto-approve

rebuild_all: destroy build
