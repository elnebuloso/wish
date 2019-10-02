# wish

[![Build Status](https://travis-ci.com/elnebuloso/wish.svg?branch=master)](https://travis-ci.com/elnebuloso/wish)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/wish.svg)](https://hub.docker.com/r/elnebuloso/wish)
[![GitHub](https://img.shields.io/github/license/elnebuloso/wish.svg)](https://github.com/elnebuloso/wish)

universal command runner

## dependencies

- docker needs to be installed
- wish is a command, run through docker

## installation

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

### docker run environment variables

- use this environment variables in the wish runner script

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

```
WISH_DOCKER_IMAGES_PULL_PERIOD=1 hour
```
- when wish should pull depended docker images
- values like: 1 hour, 10 minutes, 1 day etc.
- default 1 hour


## usage

- commands are called on the current directory, mounted into wish through docker
- because of mounting the docker socket, the commands are always executed onto the current directory

```
wish --version
wish --help
```

### running a command

```
wish [command]
```

### running a command with on-the fly config

```
wish --env [environment_variable=value] [command]
wish --env [environment_variable=value] --env [environment_variable=value] [command]
```

## commands

### bash

```
wish bash
```

### hello-world

```
wish hello-world
```

### demo

- demonstration of the usage of flags and options
- helpful for how-to implement new commands

```
wish demo
wish demo --flag
wish demo --flag --data foo
wish demo --flag --data foo bar baz
```

### composer

```
wish composer [arguments]
wish composer --version
```

#### environment variables

```
WISH_COMPOSER_DOCKER_IMAGE=composer
WISH_COMPOSER_DOCKER_IMAGE_TAG=latest
WISH_COMPOSER_DOCKER_IMAGE_CMD=
WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME=wish-composer-cache
WISH_COMPOSER_DOCKER_IMAGE_CACHE_DIR=/tmp
```

### csso

```
wish csso [arguments]
wish csso --version
```

#### environment variables

```
WISH_CSSO_DOCKER_IMAGE=elnebuloso/csso-cli
WISH_CSSO_DOCKER_IMAGE_TAG=latest
WISH_CSSO_DOCKER_IMAGE_CMD=
```

### phing

```
wish phing [arguments]
wish phing --version
wish phing --help
```

#### environment variables

```
WISH_PHING_DOCKER_IMAGE=elnebuloso/phing
WISH_PHING_DOCKER_IMAGE_TAG=latest
WISH_PHING_DOCKER_IMAGE_CMD=
```

### google-closure-compiler

```
wish google-closure-compiler [arguments]
wish google-closure-compiler --version
wish google-closure-compiler --help
```

#### environment variables

```
WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE:=elnebuloso/google-closure-compiler
WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_TAG:=latest
WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_CMD:=
```

## extending wish

- add commands as shell scripts under /usr/local/bin

## development

```
.\dev.ps1 build
.\dev.ps1 wish [command]
```