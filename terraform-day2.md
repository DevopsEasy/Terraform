### Installing Terraform

* Terraform is an open-source project developed in Google’s GO language
* Installing Terraform is much like downloading an exe/executable on your system adding it to the PATH variable and using it.
* Mac users => Install Homebrew [Refer Here](https://docs.brew.sh/Installation)

```
# Launch terminal 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

* Windows Users => Install Chocolatey [Refer Here](https://chocolatey.org/install)

```
# Launch Powershell as admin
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Close your terminal/Powershell and relaunch as admin
```

* Install Terraform
    * Windows => choco => ``` choco install terraform -y ```
    * Mac => brew => ``` brew install terraform ``` [Refer Here](https://formulae.brew.sh/formula/terraform)

## Terraform Terminologies

* Provider: This specifies terraform where to create infrastructure
* Resource: Resources are the core elements of your infrastructure. 
    * The inputs which we specify about the resource are called as ``` arguments ```
    * When we create resources using terraform they specify some outputs of the resource which are called as ``` attributes ```
    * DataSource: This helps us in querying information (about resources) from terraform configuration.

## Writing a Terraform Configuration file
* We need to specify the provider 
    * Syntax:
        ```
        provider "<name-of-provider>" {
          arg1 = "value1"
          ...
          ..
          argn = "value2"
         }
        ```
* We need to find a right resource from the provider

```
resource "<resource-type>" "<resource-name>" {
    arg1 = "value1"
    ...
    ..
    argn = "value2"

}
```
* Create private s3 bucket in AWS Cloud

```
provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "my-tf-de-s3-bucket"
    acl = "private"
}
```
### Activity: From Terraform Create an S3 bucket in AWS Cloud

* Manual Steps:
    * Login into AWS Console
    * create s3 bucket
* Approach in Terraform
    * Find the Provider, Google: terraform aws provider
