/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 3.3"
}

provider "google-beta" {
  version = "~> 3.3"
}

resource "random_id" "rand_custom_id" {
  byte_length = 2
}

/******************************************
  Module custom_role call
 *****************************************/
module "custom-roles-org" {
  source = "../../modules/custom_role_iam/"

  target_level = "org"
  target_id    = var.org_id
  role_id      = "iamDeleter_${random_id.rand_custom_id.hex}"
  permissions  = ["iam.roles.list", "iam.roles.delete"]
  description  = "This is an organization level custom role."
  members      = ["group:test-gcp-org-admins@test.infra.cft.tips", "group:test-gcp-billing-admins@test.infra.cft.tips"]
}
