from pathlib import Path

ROOT = Path(r"D:\Vault\Vault-Cluster")
OUTPUT = ROOT / "vault_cluster_repo_dump.txt"

SKIP_DIRS = {
    ".git",
    ".terraform",
    "__pycache__",
    ".idea",
    ".vscode",
    "node_modules",
}

SKIP_FILES = {
    "terraform.tfstate",
    "terraform.tfstate.backup",
    "local.auto.tfvars",
    "vault_cluster_repo_dump.txt",
}

SKIP_EXTENSIONS = {
    ".exe",
    ".dll",
    ".bin",
    ".zip",
    ".tar",
    ".gz",
    ".tgz",
    ".png",
    ".jpg",
    ".jpeg",
    ".gif",
    ".pdf",
    ".ico",
}

SENSITIVE_PATTERNS = {
    ".key",
    ".pem",
    ".p12",
    ".pfx",
}

def should_skip(path: Path) -> bool:
    if any(part in SKIP_DIRS for part in path.parts):
        return True

    if path.name in SKIP_FILES:
        return True

    if path.suffix.lower() in SKIP_EXTENSIONS:
        return True

    if path.suffix.lower() in SENSITIVE_PATTERNS:
        return True

    return False


files = []

for path in ROOT.rglob("*"):
    if path.is_file() and not should_skip(path):
        files.append(path)

files.sort()

with OUTPUT.open("w", encoding="utf-8") as out:
    out.write("=" * 100 + "\n")
    out.write("VAULT-CLUSTER REPOSITORY DUMP\n")
    out.write("=" * 100 + "\n\n")

    out.write("REPOSITORY STRUCTURE\n")
    out.write("-" * 100 + "\n")

    for path in files:
        out.write(str(path.relative_to(ROOT)) + "\n")

    out.write("\n\n")

    for path in files:
        relative = path.relative_to(ROOT)

        out.write("=" * 100 + "\n")
        out.write(f"FILE: {relative}\n")
        out.write("=" * 100 + "\n\n")

        try:
            content = path.read_text(encoding="utf-8")
            out.write(content)
        except UnicodeDecodeError:
            out.write("[Skipped: non-text/binary file]")

        out.write("\n\n")

print(f"Repo dump created at:\n{OUTPUT}")

