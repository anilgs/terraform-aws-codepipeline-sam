# -----------------------------------------------------------------------------
# Variables: General
# -----------------------------------------------------------------------------

variable "environment" {
  description = "AWS resource environment/prefix"
}

variable "region" {
  description = "AWS region"
}

variable "resource_tag_name" {
  description = "Resource tag name for cost tracking"
}

variable "codepipeline_sam_module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

# -----------------------------------------------------------------------------
# Variables: CodeBuild
# -----------------------------------------------------------------------------

variable "build_image" {
  type        = string
  default     = "aws/codebuild/standard:4.0"
  description = "Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html"
}

variable "build_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "Instance type of the build instance"
}

variable "build_timeout" {
  default     = 5
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed"
}

variable "buildspec" {
  type    = string
  default = "Build YML specification file"
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled"
}

variable "privileged_mode" {
  type        = bool
  default     = false
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "environment_variable_map" {
  type = list(object({
    name  = string
    value = string
    type  = string
  }))
  default     = []
  description = "Additional environment variables for the build process. The type of environment variable. Valid values: PARAMETER_STORE, PLAINTEXT, and SECRETS_MANAGER."
}

# -----------------------------------------------------------------------------
# Variables: CodePipeline
# -----------------------------------------------------------------------------
variable "stack_name" {
  type        = string
  description = "AWS SAM stack name"
}


variable "repo_name" {
  type        = string
  description = "Codecommit repository name"
}

variable "repo_default_branch" {
  type        = string
  description = "Codecommit branch name"
  default     = "master"
}

variable "poll_source_changes" {
  type        = string
  default     = "false"
  description = "Periodically check the location of your source content and run the pipeline if changes are detected"
}