# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging. 
You can refer for more information about semantic versioning at [semver.org](https://semver.org/).

The general format is as follows:

**MAJOR.MINOR.PATCH**, e.g., `1.0.1`

- **MAJOR version** when you make incompatible API changes.

- **MINOR version** when you add functionality in a backward-compatible manner.

- **PATCH version** when you make backward-compatible bug fixes.


## Install the Terrafrom CLI

### Consideration with the Terrafrom CLI changes
- The Terraform CLI intallation instruction have changed due to gpg keyring changes. 
So we needed to refer to the latest install CLI instruction via Terraform Documentation
and change the scripting for install
-my shell script did not run without the .sh extension and I added it everytime while running **instal_terraform_cli.sh**

[Install Terrafrom CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Example of cheking OS version:

```sh
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs

[How to check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line//)


### Refactoring into Bash Scripts

While fixing the terraform CLi gpg deprecation issue we notice that bash scripts steps were a considerable amount more code. 
So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terrform_cli)


- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier way to debugand execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLi

### Shebang Consideration

A shebang (pronounced sha-bang) tells the bash script what program that will interpet the script. eg `#!/bin/bash`

ChatGPT recommended to use this format for bash `#!/usr/bin/env bash` 

- for prtability
- will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)


#### Execution Consideration

When executing the bash script we can use the `./` shorthand notation to execute the bash script

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yaml we need to point the script to a program to interpret it.

eg. `source ./install-terraform-cli.sh`



#### Linux Permission Consideration

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode

```sh
chmod u+x ./bin/install-terraform-cli
```
alternatively:

```sh
chmod 744 ./bin/install-terraform-cli
```

https://en.wikipedia.org/wiki/Chmod

https://en.wikipedia.org/wiki/

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun we restart an existing workspace

https://www.gitpod.io/docs/configure/workspaces/tasks




## Working Env Vars

To list all Environment Variables (Env Vars), you can use the `env` command.

You can filter specific env vars using grep, for example: `env | grep AWS_`



#### Setting and Unsetting Env Vars
In the terminal we can set using `export Hello= 'world`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```


## Printing Vars

We can print an env var using echo eg. `echo $HELLO``

### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. ``.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```
All future workspaces launched will set the env vars for all bash terminals opened in thoes workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-senstive env vars.


#### PROJECT_ROOT removed from install-terraform-cli

 The env variable along with command was mistakenly kept in install-terraform-cli file and it is removed.
 Removed content:
 
 PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'


 #### AWS CLI Istallation

 AWS CLI is installed for the project via the bash script `./bin/install_aws_cli`
 
 [Getting Started Install (AWS CLI) ](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```
 
 If it is succesful you should see a json payload return that looks like this:

```json
 {
    "UserId": "AIEAVUO15ZPAAJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM User in order to the user AWS CLI.

- Logged in to AWS console and created **iamadmin** user form IAM Console
- The **iamadmin** user is currently given **Admin Acess**


# Terraform Basics


### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)


### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`


### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.


### Terraform Plan

`terrafom plan`

This will produce a changeset detailing the current state of our infrastructure and the upcoming modifications.

You can produce this changeset, referred to as a `plan` for use in subsequent application processes, but frequently, you may opt not to generate an output.


### Terraform Apply

`terraform apply`

This will initiate the execution of a plan, transferring the changeset for execution by Terraform. The `apply` operation will request confirmation with a `yes` or `no` prompt.

If there's a need to automatically approve an `apply`, you can do so by specifying the auto-approve flag, for instance: `terraform apply --auto-approve`


### Terraform Destroy

`terraform destroy` This will basically destroy the resources that were created.

You can also employ the auto-approve flag to bypass the approval prompt, like so: `terraform apply --auto-approve`


### Terraform Lock Files

The file `.terraform.lock.hcl` includes the specified versions for providers or modules that are intended for use with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github



### Terraform State Files

The file `.terraform.tfstate` holds crucial data regarding the present state of your infrastructure.

It's essential to note that this file **should never be committed** to your version control system (VCS), as it may contain sensitive information. 

Losing this file means losing insight into your infrastructure's current state.

Additionally, ``.terraform.tfstate.backup` serves as a backup of the previous state file.


### Terraform Directory


The `.terraform` directory houses Terraform provider binaries.


# Issue was with main.tf file

- Here are some important changes I made:

- Updated the aws provider source to `hashicorp/aws` since we are working with AWS resources.
- Uncommented the provider "aws" block and set the AWS region to `us-east-1`. You should replace this with your desired region.
- Uncommented the resource `aws_s3_bucket` `example` block and added ACL and tags configurations.
- Make sure to replace `MyBucket` in the tags block with your desired bucket name prefix. After making these changes, run terraform init and terraform apply to apply the configuration and create the S3 bucket with the specified settings. 
- Ensure that your AWS credentials and configuration are correctly set up for Terraform to access your AWS account.

# Random Bucket Created
 aws_s3_bucket = "cvexxynmxo4qz4n68koat0kska7ijeyh"

 ## Finally the randomly create bucket was destroyed using
 `terrafrom destroy`

 ## Error Encountered

**Issue Summary:**

When running `terraform plan` in Terraform Cloud, the following errors were encountered:

1. **No Valid Credential Sources Found:** The `provider "aws"` in the `main.tf` file encountered an error indicating no valid credential sources were found. It's recommended to refer to [Terraform AWS Provider documentation](https://registry.terraform.io/providers/hashicorp/aws) for guidance on providing credentials.

2. **Failed to Refresh Cached Credentials:** An error occurred during an attempt to refresh cached credentials, stating that no EC2 IMDS (Instance Metadata Service) role was found. This resulted in the operation failing with a context deadline exceeded error.

### This will be later addressed by creating "generate_tfrc_credentials.sh" bash script