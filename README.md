# GRC Engineer GCP Portfolio

This repository (`cgep-labs`) is a hands-on portfolio of Governance, Risk, and Compliance (GRC) engineering labs. Each lab turns a NIST 800-53 control into working infrastructure-as-code, policy-as-code, or automated evidence, with the goal of showing that compliance can be built, enforced, and proven through engineering rather than paperwork.

The labs span AWS and GCP and build on one another, moving from foundational setup, through compliant infrastructure, to automated enforcement, signed evidence, and machine-readable compliance documentation.

## Labs

### Lab 1: Environment Setup

Installed Git Bash (Windows), Terraform, and the AWS CLI, then stood up the `cgep-labs` repository that holds all subsequent work.

### Lab 2: Compliant Infrastructure and Evidence

#### 2.1 Compliant AWS S3 Bucket

Terraform files for a single AWS S3 bucket that satisfies five NIST 800-53 controls: **SC-28** (protection of information at rest), **AU-3** (content of audit records), **AU-6** (audit review, analysis, and reporting), **CM-6** (configuration settings), and **AC-3** (access enforcement). The configuration emits machine-readable evidence for every one of these controls.

#### 2.2 Compliant GCP Terraform Module

A Terraform module on GCP that hardcodes **SC-12** (cryptographic key establishment and management), **SC-13** (cryptographic protection), **SC-28**, **AU-11** (audit record retention), and **CM-6**, so consumers cannot turn the compliance floor off. The module also emits a compliance attestation.

#### 2.3 Immutable Evidence Vault

An S3 Object Lock vault that refuses deletion by design. Evidence is bundled, hashed, and uploaded, with the resulting `VersionId` recorded for traceability.

### Lab 3: Policy as Code

#### 3.1 Rego Policies for GCP

Three Rego policies written against GCP fixtures, each mapped to a NIST 800-53 control. The policies include `_test.rego` fixtures and were validated against a real `terraform plan -json` run.

#### 3.2 Conftest as a Fail-Closed Gate

Wired Conftest into the Terraform plan workflow as a fail-closed gate, so a plan that violates policy cannot pass. Added AWS variants of the SC-28 and AC-3 policies and proved a blocked merge using a deliberately broken plan.

### Lab 4: CI/CD Automation and Signed Evidence

#### 4.1 GitHub Actions with AWS OIDC

Wired AWS OIDC trust into a GitHub Actions workflow that runs `terraform plan`, Conftest, and tfsec on every pull request. The workflow fails closed on high-severity findings and uploads a named evidence artifact for each run.

#### 4.2 Keyless Signing with Cosign

Added keyless Cosign signing through GitHub OIDC and pushed the signed bundles into the vault. The full chain is verified end to end with a single script.

### Lab 5: Continuous Monitoring and Cloud Governance

#### 5.1 CloudTrail and Security Hub

Stood up multi-region CloudTrail with log-file validation, and enabled Security Hub on the NIST 800-53 Rev 5 standard, all through Terraform. The first wave of findings was pulled as JSON evidence.

#### 5.2 GCP Org Policy and Workload Identity Federation

Enforced GCP Org Policy at the API level, replaced service account keys with Workload Identity Federation for GitHub Actions, and turned on the Data Access audit logs that are off by default.

### Lab 6: OSCAL Documentation

Authored a valid OSCAL Component Definition for a Terraform module and wired its evidence URIs to objects in the vault. The full chain was validated with `trestle`.

## Tools and Technologies

- **Infrastructure as code:** Terraform
- **Cloud platforms:** AWS and GCP
- **Policy as code:** Open Policy Agent (Rego) and Conftest
- **Security scanning:** tfsec
- **CI/CD:** GitHub Actions with OIDC
- **Signing:** Sigstore Cosign (keyless)
- **Compliance frameworks:** NIST 800-53 Rev 5 and OSCAL (via `trestle`)