# terraform/primitives/compliant-gcs-prod/main.tf  (module block; also include provider + outputs from Step 4)
module "data_bucket" {
  source = "../../modules/compliant-gcs-bucket"

  gcp_project        = "grcproject-514220"
  project_label      = "cgep-lab"
  environment        = "prod"
  retention_days     = 365
  bucket_name_suffix = "prod-data-grk" # use your personal suffix, e.g. prod-data-<your-initials>
}

