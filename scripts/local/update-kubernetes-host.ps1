$server = kubectl config view --minify `
  -o jsonpath="{.clusters[0].cluster.server}"

if (-not $server) {
    throw "Unable to determine Kubernetes API server from kubeconfig."
}

$uri = [System.Uri]$server

$vaultKubernetesHost = "https://control-plane.minikube.internal:$($uri.Port)"

$content = @"
kubernetes_host = "$vaultKubernetesHost"
"@

[System.IO.File]::WriteAllText(
    "D:\Vault\Vault-Cluster\terraform\vault\local.auto.tfvars",
    $content,
    [System.Text.UTF8Encoding]::new($false)
)

Write-Host "Terraform Kubernetes host:"
Write-Host $vaultKubernetesHost