# wish

[![Build Status](https://travis-ci.com/elnebuloso/wish.svg?branch=master)](https://travis-ci.com/elnebuloso/wish)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/wish.svg)](https://hub.docker.com/r/elnebuloso/wish)
[![GitHub](https://img.shields.io/github/license/elnebuloso/wish.svg)](https://github.com/elnebuloso/wish)

universal command runner

## dependencies

- docker installed

## usage

- create your wish shortcut runner
- call available commands

```
wish [command]
wish bash
wish hello-world
wish composer
wish composer --tag latest init
```

## bash script

```
#!/bin/bash

docker pull elnebuloso/wish \
    && docker run --tty --interactive --rm --user $(id -u) \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --volume $(pwd):$(pwd) \
       --workdir $(pwd) \
       elnebuloso/wish ${@:1}
```


## powershell script

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

## development

```
.\dev.ps1 build
.\dev.ps1 wish [command]
```