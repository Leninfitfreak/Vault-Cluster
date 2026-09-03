# Vault Cluster Practice

This repository starts a new HashiCorp Vault practice project with only the reusable application baseline in place.

Current implemented flow:

`GitHub -> Argo CD -> Helm -> Minikube -> orders-service -> Kubernetes Secrets`

Vault is intentionally not implemented in this repository yet. The application uses normal Kubernetes Secrets with clearly fake local values so the baseline can run before any external Vault foundation is introduced.

## Scope

Implemented:

- `orders-service` Helm chart
- frontend, orders, consumer, PostgreSQL, Traefik ingress
- Kubernetes Secret based credentials
- one Argo CD Application for the app baseline

Not implemented:

- Vault server runtime
- Vault Secrets Operator
- dynamic database credentials
- PKI or mTLS
- recovery/DR application topology
- Terraform Vault configuration

## Local validation

```powershell
helm lint applications/orders-service
helm template orders-service applications/orders-service --namespace orders
kubectl --context vault-primary apply -k gitops/argocd/bootstrap
kubectl --context vault-primary apply -f gitops/argocd/project.yaml
kubectl --context vault-primary apply -f gitops/argocd/orders-service.yaml
```

Argo CD is the intended reconciler for application resources after bootstrap.

## Next step

Manual external Docker Vault foundation.
