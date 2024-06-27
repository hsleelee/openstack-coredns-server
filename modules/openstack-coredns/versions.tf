# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      # 아래 설정 적용 시, registry.terraform.io의 값을 확인
      source  = "terraform-provider-openstack/openstack"
      version = "1.53.0"
    }
  }
}