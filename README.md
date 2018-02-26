# Docker Scripts

## Adding

    git submodule add https://github.com/hap-build/docker scripts/docker

## Hap Config

    [build "docker"]
    cmd = "sudo ./scripts/docker/sysctl.sh"
    cmd = "sudo ./scripts/docker/install.sh"
    cmd = "sudo ./scripts/docker/install-compose.sh"
