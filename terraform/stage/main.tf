terraform {
  # required version
  required_version = ">= 0.11.7"
  backend "gcs" {
    bucket  = "mybucket-thirt13en"
    prefix  = "terraform/state"
  }
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "vpc" {
  source = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}

module "app" {
  source = "../modules/app"
  public_key_path = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone = "${var.zone}"
  db_url= "${module.db.internal_ip}"
  app_disk_image = "${var.app_disk_image}"
}
module "db" {
  source = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  db_disk_image = "${var.db_disk_image}"
}
