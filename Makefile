
TF_EXEC = terraform

TF_FILE = 

TF_PASSWORD_LINK = "https://releases.hashicorp.com/terraform-provider-random/"$(TF_PASSWORD_VERSION)"/"$(TF_PASSWORD_ZIP)

TF_PASSWORD_ZIP = "terraform-provider-random_"$(TF_PASSWORD_VERSION)"_linux_amd64.zip"

TF_PASSWORD_VERSION = "2.2.1"

zip_lambda:
	mkdir -p dist
	cd dist && rm -f *.zip && zip -jr lambda_get_data.zip ../lambda/lambda_get_data/*
	echo 'popipo'
	zip -r9 popipo.zip lambda/pymysql/ lambda/PyMySQL-0.9.3.dist-info/
	zip -g popipo.zip lambda/init_database.py 
	aws lambda update-function-code --function-name popipo --zip-file fileb://popipo.zip
	echo 'popipo'

init:
	echo "Downloading of terraform libraries"
	wget $(TF_PASSWORD_LINK)
	unzip -o $(TF_PASSWORD_ZIP) -d infra/
	rm $(TF_PASSWORD_ZIP)
	echo "Installating python libraries:"
	pip install --target ./lambda/ PyMySQL
	echo "Initation of terraform environment"
	cd infra && $(TF_EXEC) init
	cd init_infra && $(TF_EXEC) init

build:
	cd infra && $(TF_EXEC) apply -auto-approve
	echo "TODO: cd init_infra && $(TF_EXEC) apply -auto-approve"
	echo "TODO: execute lambda to set database"
	echo "TODO: cd init_infra && $(TF_EXEC) destroy -auto-approve"

build_test:
	cd lambda && zip -r9 popipo.zip pymysql/ PyMySQL-0.9.3.dist-info/
	cd lambda && zip -g popipo.zip init_database.py
	cd init_infra && $(TF_EXEC) apply -auto-approve
	cd lambda && rm popipo.zip
//	aws lambda update-function-code --function-name popipo --zip-file fileb://lambda/popipo.zip

destroy:
	cd infra && $(TF_EXEC) destroy

firstbuild: init build

rebuild: destroy build
