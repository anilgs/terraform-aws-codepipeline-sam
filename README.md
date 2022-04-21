# Terraform AWS CodePipeline for AWS SAM Applications

## About:

Deploys an AWS CodePipeline specifically designed for AWS SAM.

It requires these artifacts, amongst code obviously, in the source repository:
- AWS SAM template file (e.g. template.yaml), contains a description of your stack in CFL.
- CloudFormation Template configuration file (e.g. configuration.json), contains the parameter configuration you want to deploy your stack with. This is used during the CloudFormation Change Set, as part of the deployment stage.

## How to use:


The ``stack_name`` is what you configured as a SAM stack name.

```hcl
data "template_file" "buildspec" {
  template = file("${path.module}/codebuild/buildspec.yml")
}

module "codepipeline" {
  source = "github.com/anilgs/terraform-aws-codepipeline-sam?ref=v1.1"

  resource_tag_name = var.resource_tag_name
  environment       = var.environment
  region            = var.region

  repo_name          = var.repo_name
  repo_default_branch = var.repo_default_branch
  poll_source_changes = var.poll_source_changes

  build_image = "aws/codebuild/standard:4.0"
  buildspec   = data.template_file.buildspec.rendered

  stack_name = var.stack_name

  environment_variable_map = [
    {
      name  = "REGION"
      value = var.region
      type  = "PLAINTEXT"
    }
  ]
}
```

## Changelog

### V1.3
- Added ``codepipeline_sam_module_enabled`` on/off module switch

### V1.2
 - Added Environment variables support for CodeBuild templates.

### v1.1
 - Separated Buildspec YML file from module. See the ``./codebuild/buildspec.yml`` file for an example.

### v1.0
 - Initial release