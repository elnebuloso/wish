param(
    [string]$command = ""
)

$tag = "wish"
$pwd = [string](Get-Location)
$pwd = $pwd.Replace("\", "/")
$pwdLinux = "/host_mnt/" + $pwd.Replace(":", "").ToLower()

if ($command -eq "build") {
    docker build --rm --pull --tag ${tag} --file Dockerfile .
}

if ($command -eq "wish") {
    $dirLocal = "${pwd}"
    $dirContainer = "${pwdLinux}"

    docker run --tty --interactive --rm --volume /var/run/docker.sock:/var/run/docker.sock --volume ${dirLocal}:${dirContainer} --workdir ${dirContainer} ${tag} ${args}
}
