# app_terraform_gcp
 Web_APP using Terraform and Docker on GCP 

> #### more information

## Agenda
[Step 1:](#download) Download Terraform on Ubuntu </br>
[Step 2:](#repository) Clone Repository </br>
[Step 3: ](#configure) Configure Terraform </br>
[Step 4: ](#adapt) Adapt the default parameters </br>
[Step 5: ](#Create) Create VM with Terraform</br>
[Step 6: ](#Web_App) Web_App </br>
[Step 7: ](#Troubleshooting) Troubleshooting </br>

## Prerequisite:
#### Example with free use GCP Instance:</br>

| Produkt | Type |
|:--------------|:-------------:|
| Virtuale Machine | Ubuntu Server 20.04 |
| Amazon Machine Images | centos-7-v20210420 |
| Region |  us-central1 |
| Zone | us-central1-b |
| GCP mashine type | e2-highcpu-2 |
| Ports | 8081, 22, 3306 |


> Port 8081 — PhpMyAdmin Server </br>
> Port 3306 — MySQL Server </br>
> Port 22 — SSH </br>

## Step 1: Download Terraform on Ubuntu
***
1. Choose your IDE and create a new Project
Possible IDE: Eclipse, IntelliJ IDEA, PyCharm, Visual Studio Code etc. </br>
2. Install Terraform </br>
(Newest Version of Terraform: https://www.terraform.io/downloads)</br>
```
$ sudo apt-get install terraform
```
3. Check version - Is it properly installed?
```
$ terraform -v 
```
4. Check PATH of Terraform 
```

## Step 1: Download Terraform on Ubuntu
***
1. Choose your IDE and create a new Project
Possible IDE: Eclipse, IntelliJ IDEA, PyCharm, Visual Studio Code etc. </br>
2. Install Terraform </br>
(Newest Version of Terraform: https://www.terraform.io/downloads)</br>
```
$ sudo apt-get install terraform
```
3. Check version - Is it properly installed?
```
$ terraform -v 
```
4. Check PATH of Terraform 
```
$ which terraform which terraform 
```

## Step 2: Clone Repository
***
```
$ curl https://github.com/AnnaSokol/app_terraform_gcp.git
```

## Step 3: Configure Terraform
***
#### Add your GCP „Access Key ID“ in the le main.tf 
```
$ cd app_terraform_gcp/main.tf
```
> #### To get your access key ID ppen the Security credentials tab on GCP.com , and then choose Create access key. To see the new access key, choose Show. Your credentials resemble the following:

## Step 4: Create Instance with Terraform
***
```
$ terraform init 
$ terraform plan 
$ terraform apply 
```