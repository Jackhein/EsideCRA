provider "aws" {
  profile    = "default"
  region     = var.region
  shared_credentials_file = var.credentialFile
}

variable "region" {
	type = string
	default = "eu-west-3"
}

variable "credentialFile" {
	type = string
	default = "~/.aws/creds"
}

resource "random_password" "password" {
  length = 8
  special = true
  override_special = "_%@"
}

variable "rds_password" {
	type = string
	default = random_password.password.result
}

#local {
#	lambda_get_name_zip = "$(path.module)/../lambda_get_name.zip"
#}
