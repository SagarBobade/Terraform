// in this file we defines provider name which will be using in this project
// here we must define the providers which are not official but mention even if offical provider for the best practice

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.45.0"
    }

     linode = {
      source  = "linode/linode"
      # version = "..."
    }
    
  }
}
