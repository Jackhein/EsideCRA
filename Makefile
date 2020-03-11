
TF_EXEC = terraform

TF_FILE = 

TF_EXEC_LINK = "https://releases.hashicorp.com/terraform/"$(TF_EXEC_VESION)"/"$(TF_EXEC_ZIP)

TF_EXEC_ZIP = "terraform_"$(TF_EXEC_VESION)"_linux_amd64.zip"

TF_EXEC_VESION = "0.12.23"

TF_PASSWORD_LINK = "https://releases.hashicorp.com/terraform-provider-random/"$(TF_PASSWORD_VERSION)"/"$(TF_PASSWORD_ZIP)

TF_PASSWORD_ZIP = "terraform-provider-random_"$(TF_PASSWORD_VERSION)"_linux_amd64.zip"

TF_PASSWORD_VERSION = "2.2.1"

zip_lambda:
	mkdir -p dist
	cd lambda && rm -f setDatabase.zip
	cd lambda && zip -r9 setDatabase.zip pymysql/ PyMySQL-0.9.3.dist-info/
	cd lambda && zip -g setDatabase.zip init_database.py

install_terraform:
	echo "Install terraform version $(TF_EXEC_VERSION)"
	wget $(TF_EXEC_LINK)
	unzip $(TF_EXEC_ZIP)
	rm $(TF_EXEC_ZIP)
	sudo mv terraform /usr/local/bin/

init:
	echo "Download terraform libraries"
	wget $(TF_PASSWORD_LINK)
	unzip -o $(TF_PASSWORD_ZIP) -d infra/
	rm $(TF_PASSWORD_ZIP)
	echo "Install python libraries:"
	sudo -H pip install --target ./lambda/ PyMySQL
	echo "Initation of terraform environment"
	cd infra && $(TF_EXEC) init
	cd init_infra && $(TF_EXEC) init

build:
	cd infra && $(TF_EXEC) apply -auto-approve
	echo "TODO: build init"

build_test: zip_lambda
	cd init_infra && $(TF_EXEC) apply -auto-approve
	echo "apply lambda code"
	echo "TODO: cd init_infra && $(TF_EXEC) destroy -auto-approve"
	echo "TODO: cd lambda && rm setDatabase.zip"

destroy:
	cd infra && $(TF_EXEC) destroy

firstbuild: init build

rebuild: destroy build
