# Copilot instructions (terra_test)

## Project overview
- This repo is a set of **small, independent Terraform root modules** (each folder is run separately): `0-terraform/`, `1-terraform/`, `challenge1/`, `challenge2/`, `challenge3/`.
- `challenge3/` composes infrastructure via **local Terraform modules**: `challenge3/db/`, `challenge3/web/`, `challenge3/sg/`, `challenge3/eip/`.

## Key files to orient yourself
- Root command examples: `README.md` (shows `plan/apply`, `-target`, `import`, `state rm`).
- Provider pinning + profile usage: `0-terraform/0-providers.tf` (AWS provider uses `profile = "terraform-admin"`, region `us-east-2`, AWS provider `~> 5.94`).
- Module wiring: `challenge3/main.tf` (outputs expose `module.db.PrivateIP` and `module.web.PublicIP`).
- EC2 + user-data pattern: `challenge2/main.tf` and `challenge3/web/web.tf`.
- Security group pattern: `challenge2/main.tf` and `challenge3/sg/sg.tf` (dynamic ingress/egress from port lists).

## Working conventions (important)
- Treat each folder as its own Terraform project: run commands from inside that directory.
- Region varies by folder (e.g., `challenge1/` uses `us-west-2`, most others use `us-east-2`). Don’t “normalize” regions unless asked.
- This repo intentionally demonstrates multiple approaches:
  - Single-file root module with all resources (`challenge2/`).
  - Root module split into local modules (`challenge3/`).
  - Data sources / import examples (`0-terraform/`).
- EC2 `user_data` uses shell scripts that install Apache via `yum` (Amazon Linux-style): `challenge2/server-script.sh`, `challenge3/web/server-script.sh`. Preserve that assumption unless the AMI is changed.
- When modifying `user_data` scripts, keep `user_data_replace_on_change = true` behavior in mind (instances will be replaced on change).

## Common workflows (commands)
Run in the specific directory you’re working on:
- `terraform fmt -recursive`
- `terraform init`
- `terraform validate`
- `terraform plan`
- `terraform apply`

Targeted + import flows are used in this repo (see `README.md`):
- `terraform plan -target aws_instance.ubuntu`
- `terraform apply -target aws_instance.ubuntu`
- `terraform import aws_instance.ubuntu <instance-id>`
- `terraform state rm aws_instance.ubuntu`

## Patterns to follow when editing
- Prefer the existing style: simple resources, minimal variables, and explicit outputs.
- For security groups, follow the existing `dynamic "ingress"/"egress"` pattern driven by `list(number)` variables (see `challenge3/sg/sg.tf`).
- For module outputs, keep names consistent with current consumers (e.g., `module.web.PublicIP` depends on the `web` module output named `PublicIP`).

## When proposing changes
- Specify *which directory* the change applies to (root modules are not shared).
- Call out AWS impact (new EC2/EIP/SG resources, replacements due to `user_data` changes).
