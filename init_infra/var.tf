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
