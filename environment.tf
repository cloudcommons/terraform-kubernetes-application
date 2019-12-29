locals {
    environment = var.ENVIRONMENT == null ? terraform.workspace : var.ENVIRONMENT
    full_name = "${var.APP_NAME}-${local.environment}"
}