# wish

[![Build Status](https://travis-ci.com/elnebuloso/wish.svg?branch=master)](https://travis-ci.com/elnebuloso/wish)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/wish.svg)](https://hub.docker.com/r/elnebuloso/wish)
[![GitHub](https://img.shields.io/github/license/elnebuloso/wish.svg)](https://github.com/elnebuloso/wish)

universal command runner

## dependencies

- docker needs to be installed
- wish is a command, run through docker

## installation

- create your wish shortcut runner, see bash script, see powershell script

### environment variables

- possible settings for the wish runner

```
WISH_VERBOSE_LEVEL=0
```
- output informations when running commands
- possible values 0|1|2
- default 0

```
WISH_DOCKER_IMAGES_PULL_ALWAYS=yes
```
- should wish always pulls depended docker images
- possible values yes|no
- default yes

### bash script

```
#!/bin/bash

docker pull elnebuloso/wish \
    && docker run --tty --interactive --rm --user $(id -u) \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --volume $(pwd):$(pwd) \
       --workdir $(pwd) \
       elnebuloso/wish ${@:1}
```

### powershell script

```
# wish-dev.psm1

function wish
{
    $pwd = [string](Get-Location)
    $pwd = $pwd.Replace("\", "/")
    $pwdLinux = "/host_mnt/" + $pwd.Replace(":", "").ToLower()

    docker pull elnebuloso/wish
    docker run -it --rm --volume /var/run/docker.sock:/var/run/docker.sock --volume ${pwd}:${pwdLinux} -w ${pwdLinux} elnebuloso/wish $args
}
```

## commands

- commands are called on the current directory
- this works, because you mount your current directory to the wish docker container

```
wish --version
wish --help
```

### bash

```
wish bash
```

### hello-world

```
wish hello-world
```

### demo

```
wish demo
wish demo --flag
wish demo --flag --data foo
wish demo --flag --data foo bar baz
```
- demonstration of the usage of flags and options
- helpful for how-to implement new commands

### composer

```
wish composer [composer_arguments_and_options]
wish composer --version
```

#### environment variables

- configure your wish docker run command
- define your settings for the current command

```
WISH_COMPOSER_DOCKER_IMAGE=composer
WISH_COMPOSER_DOCKER_IMAGE_TAG=latest
WISH_COMPOSER_DOCKER_IMAGE_CMD=
WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME=wish-composer-cache
WISH_COMPOSER_DOCKER_IMAGE_CACHE_DIR=/tmp
```

#### on-the-fly configuration

```
wish composer --img [WISH_COMPOSER_DOCKER_IMAGE] [composer_arguments_and_options]
wish composer --tag [WISH_COMPOSER_DOCKER_IMAGE_TAG] [composer_arguments_and_options]
wish composer --cmd [WISH_COMPOSER_DOCKER_IMAGE_CMD] [composer_arguments_and_options]
wish composer --cache-volume [WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME] [composer_arguments_and_options]
wish composer --cache-dir [WISH_COMPOSER_DOCKER_IMAGE_CACHE_DIR] [composer_arguments_and_options]
```

### csso

```
wish csso [csso_arguments_and_options]
wish csso --version
```

#### environment variables

- configure your wish docker run command
- define your settings for the current command

```
WISH_CSSO_DOCKER_IMAGE=elnebuloso/csso-cli
WISH_CSSO_DOCKER_IMAGE_TAG=latest
WISH_CSSO_DOCKER_IMAGE_CMD=
```

#### on-the-fly configuration

```
wish csso --img [WISH_CSSO_DOCKER_IMAGE] [composer_arguments_and_options]
wish csso --tag [WISH_CSSO_DOCKER_IMAGE_TAG] [composer_arguments_and_options]
wish csso --cmd [WISH_CSSO_DOCKER_IMAGE_CMD] [composer_arguments_and_options]
```

### phing

```
wish phing [csso_arguments_and_options]
wish phing --version
wish phing --help
```

#### environment variables

- configure your wish docker run command
- define your settings for the current command

```
WISH_PHING_DOCKER_IMAGE=elnebuloso/phing
WISH_PHING_DOCKER_IMAGE_TAG=latest
WISH_PHING_DOCKER_IMAGE_CMD=
```

#### on-the-fly configuration

```
wish phing --img [WISH_PHING_DOCKER_IMAGE] [composer_arguments_and_options]
wish phing --tag [WISH_PHING_DOCKER_IMAGE_TAG] [composer_arguments_and_options]
wish phing --cmd [WISH_PHING_DOCKER_IMAGE_CMD] [composer_arguments_and_options]
```

## extending wish

- add commands as shell scripts under /usr/local/bin

## development

```
.\dev.ps1 build
.\dev.ps1 wish [command]
```