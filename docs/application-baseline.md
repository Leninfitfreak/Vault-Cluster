# Application Baseline

The baseline deploys one local application environment to the existing Minikube app cluster.

Current ownership model:

`Git -> Argo CD -> Helm -> Kubernetes`

The application currently reads credentials from normal Kubernetes Secrets:

- `orders-service-credentials`: `API_KEY`, `DB_USERNAME`, `DB_PASSWORD`
- `external-service-credentials`: local fake external token for the demo boundary

All values committed here are fake local POC values. No Vault token, Shamir share, private key, Terraform state, or real credential belongs in this repository.

Vault is not implemented yet. There are no `VaultConnection`, `VaultAuth`, `VaultStaticSecret`, `VaultDynamicSecret`, or `VaultPKISecret` resources in this baseline.

DR/recovery application behavior is also out of scope for this repository baseline.
