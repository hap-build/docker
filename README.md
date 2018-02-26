# Docker Scripts

## Adding

    git submodule add git@github.com:hap-build/docker scripts/docker

## Hap Config

    [build "docker"]
    cmd = "./scripts/docker/sysctl.sh"
    cmd = "./scripts/docker/install.sh"
    cmd = "./scripts/docker/install-compose.sh"
