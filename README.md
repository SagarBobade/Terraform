# Terraform

There are 3 main tasks of Terraform - 
1. It is an infrastructure provisioning tool, means adding new servers, network configuration, adding Load balancer - configuration at infrastructure level.
2. Configuration of provisioned infrastrucure - installing apps on servers, managing those apps, prepare infrastructure to deploy the app.
3. Deployment of application.

But you know, Docker can do both 2nd and 3rd task.
Terraform and ansible can do somewhat similar tasks.

There are many tools available in the market for these task they can not do all tasks all alone, so can be differentiate in Procedural and declarative tools, some are mutable and immutable tools and some are agent and agentless tools.

what is differencet between Ansible and Terraform -
1. Both IaC tools - Provisioning, Configuring and managing infrastructure.
2. Ansible is mainly Configuration tool and Terraform is mainly infrastructure provisioning tool.
3. Ansible is mature and Terraform is new. 
4. Both can be used at a time.

It follows a declarative approach and not a procedural - In a declarative approach, you will tell what you need and not how it is to be done. Just say what you want in your Infrastructure, and it will manage all the necessary steps to get the things done

Files -
1. main.tf - This file defines what to create / what will be the end result / desired state.
Difference between current and desired state is a Plan. i.e., Plan means what to Create/Update/Destroyed ?

There are many providers - AWS, Azure, Kia, GCP, Alibaba etc. There are over 100 providers are there.

What is its Core?
It’s a binary written in Go programming language. The compiled binary corresponds to CLI terraform.
Core is responsible for :
Reading the configuration files, i.e., IaC.
State management of various resources.
Construction of resource graph.
Execution of plan.
Communication with plugins.

Commands -
1. Refresh - Gets updated state of infrastructure from provider.
2. Plan - Creates execution plan. Determines what actions are necessary to achieve the desired state.
3. Apply - Executes the plan.
4. Destroy - Destroy the infrastructure sequentially.

For development, you should install Terraform plugin in VSCode IDE.
