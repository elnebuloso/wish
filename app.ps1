param(
    [string]$command = "",
    [string]$dir = ""
)

$tag = "wish-dev"
$pwd = [string](Get-Location)
$pwd = $pwd.Replace("\", "/")
$pwdLinux = "/host_mnt/" + $pwd.Replace(":", "").ToLower()

if ($command -eq "build") {
    docker build --rm --pull --tag ${tag} --file Dockerfile .
}
