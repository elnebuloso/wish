# wish

universal command runner

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