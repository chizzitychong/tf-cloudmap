terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.64.0"
    }
  }
}

#setting the region
provider "aws" {
  region = var.region
}

#creating the VPC block
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#creating the Cloudmap namespace
resource "aws_service_discovery_http_namespace" "namespace" {
  name        = var.namespace_name
  description = var.namespace_description
}

#creating the Cloudmap service inside the namespace 
resource "aws_service_discovery_service" "service" {
  name = var.service_name
  namespace_id = aws_service_discovery_http_namespace.namespace.id 
}