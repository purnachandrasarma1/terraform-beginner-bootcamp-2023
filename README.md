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