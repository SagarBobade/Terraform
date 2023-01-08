# Terraform

Here we have described understanding of terraform.

- [Tasks of Terraform](#Tasks-of-Terraform)
- [Difference between Ansible and Terraform](#Difference-between-Ansible-and-Terraform)
- [Terraform Files](#Terraform-Files)
- [Terraform Core](#Terraform-Core)
- [Commands](#Commands)
- [Output](#Output)
- [Pass value to a variable](#Pass-value-to-a-variable)
- [Provisioners](#Provisioners)
- [remote-exec](#remote-exec)
- [local-exec](#local-exec)
- [Module](#Module)
- [Shared remote storage](#Shared-remote-storage)
- [Entry script](#Entry-script)
- [Reference links](#Reference-links)
- [Best practice using terraform](#Best-practice-using-terraform)
- [Mini project](#Mini-project)


### Tasks of Terraform
1. It is an infrastructure provisioning tool, means adding new servers, network configuration, adding Load balancer - configuration at infrastructure level.
2. Configuration of provisioned infrastrucure - installing apps on servers, managing those apps, prepare infrastructure to deploy the app.
3. Deployment of application.

But you know, Docker can do both 2nd and 3rd task.
Terraform and ansible can do somewhat similar tasks.


### Difference between Ansible and Terraform
1. Both IaC tools - Provisioning, Configuring and managing infrastructure.
2. Ansible is mainly Configuration tool and Terraform is mainly infrastructure provisioning tool.
3. Ansible is mature and Terraform is new. 
4. Both can be used at a time.

There are many tools available in the market for these tasks, but they can not do all tasks all alone. 
They can be differentiate in Procedural and declarative tools, some are mutable and immutable tools and some are agent and agentless tools.

It follows a declarative approach and not a procedural - In a declarative approach, you will tell what you need and NOT how it is to be done. Just say what you want in your Infrastructure, and it will manage all the necessary steps to get the things done


### Terraform Files
1. main.tf - This file defines what to create / what will be the end result / desired state.
Difference between current and desired state is a Plan. i.e., Plan means what to Create/Update/Destroyed ?
2. terrafrom.tfstate = stores current state of resources which are created in mentioned provider account. Terraform maintains the current state and desired state in files.
3. terraform.tfstate.backup = stores previous state of resources which were created in mentioned provider account
4. .tfvars - Values are defined in this file.
5. variables.tf - Set as values in this file of root


### Terraform Core
It’s a binary written in Go programming language. The compiled binary corresponds to CLI terraform.
Core is responsible for :
Reading the configuration files, i.e., IaC.
State management of various resources.
Construction of resource graph.
Execution of plan.
Communication with plugins.

There are many providers - AWS, Azure, Kia, GCP, Alibaba etc. There are over 100 providers are there.


### Commands
1. Terraform Refresh - Usage : terraform refresh - Gets updated state of infrastructure from the provider.
2. Terraform Plan - Usage : terraform plan [options]- Creates execution plan. Determines what actions are necessary to achieve the desired state.
3. Terraform Apply - Usage : terraform apply [options] [plan file] - Executes the plan.
4. Terraform Destroy - Usage : terraform destroy [options] - Destroy the infrastructure sequentially, we dont have to know in which order you need to delete the resources.
5. Terraform init - Usage : Used to execute this command after a module gets added or updated.
6. Terraform State - Usage : terraform maintains the current state and desired state.
   - Terraform State list - Usage : used to list the provider resources
   - Terraform State show - Usage : used to see details of particular resource
   - Terraform State mv - Usage : terraform state mv [options] SOURCE DESTINATION
   - Terraform State rm - Usage : TO ADD HERE
   - Terraform State pull - Usage : TO ADD HERE
   - Terraform State push - Usage : TO ADD HERE
   - Terraform State replace-provider - Usage : TO ADD HERE

For development, you should install Terraform plugin in VSCode IDE.


### Output
  we can print or reuse return values by this keyword as -
ex. 
```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```

### Pass value to a variable
1. While Terraform-apply command - we get prompt to enter value for variable - we need to declare using keyword "variable"
2. While Terraform-apply command - pass commandline argument as - terraform apply -var  "variable_name=value"
3. best practice and most efficient - using variable file - fileName.tfvars - declare variable there. same like yml file in ansible but in order to make it work we have to declare "variable" section in main.tf file.
If we give variable file name as - "terraform.tfvars" then terraform will automatically recognize/find variable file and use their variables. 
If we give different file name then - we have to pass variable file name as command - "terraform apply -var-file variable_filename.tfvars"

Usecase for using variable = we can setup same infra for different types of environment like - QA, development etc. like ansible we can create different files for different environments.

we can use feature of default value in terraform, which will make passing variable file optional.
Also for variable, we can set variable type - Boolean, String, Number

we can define list type of variable too and access nth number of variable in main.tf file as -
in variblefile.tfvars file -
```
subnet_cidr_block = ["172.31.48.0/20", "172.31.38.0/20"]
```

In data section -



in main.tf file -
```
var.vpc_cidr_block[0]
```

so we may update descritpion of variable section also (this is optional).

likewise we can define type of "Object" too
ex. 

Do not use useredentials directory inside script.

**There are 2 ways the credentials -** 
1. environmental variable - using "export AWS_SECRET_ACCESS_KEY=ABCD" - just use same variable name as it should be declare inside "provider" section.
  check environmental variables using - "env | grep AWS" OR we can declare those credentials inside ~/.aws/credentials file. Terraform will automatically picked it up. If we are using this way then we can remove credentials/keys provided in Provider section of main.tf file. For this also we need to declare "variable" section.
2. If we want to use variable inside or append to other string then we need to use it as - "${var.environment}-otherString"


### Provisioners
Execute commands on virtual server, as a initial data when launching the instance. 
This is to be done by Terraform Provisioners.


## remote-exec
    Invokes script on remote server after it is created. and it is done by two ways -
    inline - list of commands
    
ex.
in ec2 creation task -
```
connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file(var.private_key_location)
}

provisioner "remote_exec" {
        inline = [
            "export ENV=dev"
            "mkdir newdir"
        ]
}
```

and script - path
```
provisioner "remote_exec" {
    script = file("entry_script.sh")
}
```

remember, entry_script.sh script must on remote server in order to exeute it.
 But to pass that script on remote machine, there is another provisioner in terraform as "file"
 so, this provisiooner is used to transfer file or directory from local to newly created server as below -
 
 ```
 provisioner "file" {
    source = "entry_script.sh"
    destination =  "home/ubuntu/entry_script-on-ec2.sh"
 }
```
 
 we can execute provisioners on other resource too, but we have to keep connection section inside that provisioner section.
 
 ## local-exec
    Invokes a local executable/executes locally after a resource is created.

```
provisioner "local-exec" {
    command = "echo after creation of resource"
 }
```
But after all terraform does not recommend "remote_exec" provisioner. See more info in official documentation. https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort
    Execute commands on virtual server using user_data attribute instead of provisioners.
    We can use Configuration management tools like ansible, chef, puppet for executing   commands on remote server or we can execute script from CICD tools like jenkins.
    If provisioners gets failed then instance gets terminated.
  
 
 ### Module
  If we write code in one single file then file will be huge and complex, no overview. So there is another concept is called as Module.
  First we will break our file in to parts, "logical parts" of our configuration. We package them together in folders. These folders will represet as       modules and we can reuse them. We can make it parameterzed like functions in programming language. also we can access output of modules as objects of     created resources or its attributes.
 
There are already created modules by terraform, by other companies or individual developers. We can use them, also we can create our own modules.
 
So, now the Project structure should be -
 - main.tf 
 - variables.tf
 - outputs.tf
 - providers.tf
 - modules
 
We dont have to link these files in to main.tf file. It gets linked automatically.

First of all, lets understand again -
values are passed to child module as argument via variables.tf in child module.

 To use the user defined module in main.tf file and pass the arguments as below -

```
module "tempName" {
     source = "modules/moduleName"
     
  }
```
  
  
 How to export resources attributes to parent module, like return values.
 we will write something like below in output.tf file of module -
```
 output "name" {
    value = reourceType.resourceName
 }
```
And it will be priting the output.tf file after its module gets executed.
whenever we do add or change module we will have to execute the command - terraform init before terraform apply.

You know, we can also use modules created by terraform, providers and community module. like aws-vpc, aws-subnet.
Now read how it is defined in the official documentation.


### Shared remote storage
In order to use this project in team, everyone must have latest version of tf file.
So we can store that file on aws s3 bucket.
but in main.tf lets delcare the configuration as below -

```
terraform {
    required_version = ">=0.12"
    backend "s3" {
        bucket = "myapp-bucket"
        key = "myapp/state.tfstate"
        region = "ap-south-1"
    }
}
```

### Entry script
Inside resource, using user_data keyword as below -

```
user_data = <<EOF
              #!/bin/bash
              sudo yum update -y && sudo yum install -y docker
            EOF
```
This will executed only once, while create.
And if you have large and complicated shell script, then we can simply write the -

user_data = file("entry-script.sh")
this shell script should be inside project which will be executed on remote resource once created. But for above both, we will not get error message if any step gets failed. Terraform doesn't have control over executing these code. Once infrastructure provisioning done of that resource then it passes the code to execute to the resource providre. AWS in our case.


### Reference links
https://developer.hashicorp.com/terraform/language
https://developer.hashicorp.com/terraform/cli


### Best practice using terraform
1. Do not change state file directly, change only by terraform command. Otherwise we will get an unexpected results.
2. Use shared remote storage like S3.
3. Do not execute terraform apply command by multiple team members at a time. You will get conflicts or unexpected results. Lock the state file until writing of state file is completed. In this way you can prevent concurrent runs to your state file. Look in to how to do it.
4. Enable versioning feature of S3 bucket.
5. Keep git versioning for tf file also. Consider terraform project also like an application project. Do branching, reviewing and testing before merging the feature branch code.
6. Should be CICD pipeline, it should not executed by any team members machine.
7. Keep seperate tfstate file for each environment.


### Mini project
Create VPC
Create Custom subnet
Create Route table and Internet gateway - route table gets created automatically whenever we create vpc and NACL is firewall for subnet. Internet gateway is like 
Provision EC2 instance
Deploy nginx Docker container
-Create security group (firewall)

