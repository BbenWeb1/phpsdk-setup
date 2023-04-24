param (
    [Parameter(Mandatory)] [String] $version,
    [Parameter(Mandatory)] [String] $arch,
    [Parameter(Mandatory)] [String] $ts
)

$ErrorActionPreference = "Stop"

$versions = @{
    "7.0" = "vc14"
    "7.1" = "vc14"
    "7.2" = "vc15"
    "7.3" = "vc15"
    "7.4" = "vc15"
    "8.0" = "vs16"
    "8.1" = "vs16"
    "8.2" = "vs16"
}
$vs = $versions.$version
if (-not $vs) {
    throw "unsupported version"
}

Write-Output "Install PHP SDK ..."

$temp = New-TemporaryFile | Rename-Item -NewName {$_.Name + ".zip"} -PassThru
$url = "https://github.com/php/php-sdk-binary-tools/archive/refs/heads/master.zip"
Invoke-WebRequest $url -OutFile $temp
Expand-Archive $temp -DestinationPath "."
Rename-Item "php-sdk-binary-tools-master" "php-sdk"
$baseurl = "https://windows.php.net/downloads/releases/archives"
$releases = @{
    "7.0" = "7.0.33"
    "7.1" = "7.1.33"
    "7.2" = "7.2.34"
    "7.3" = "7.3.33"
}
$phpversion = $releases.$version
if (-not $phpversion) {
    $baseurl = "https://windows.php.net/downloads/releases"
    $url = "$baseurl/releases.json"
    $releases = Invoke-WebRequest $url | ConvertFrom-Json
    $phpversion = $releases.$version.version
    if (-not $phpversion) {
        $baseurl = "https://windows.php.net/downloads/qa"
        $url = "$baseurl/releases.json"
        $releases = Invoke-WebRequest $url | ConvertFrom-Json
        $phpversion = $releases.$version.version
        if (-not $phpversion) {
            throw "unknown version"
        }
    }
}

$tspart = if ($ts -eq "nts") {"nts-Win32"} else {"Win32"}

ForEach ($Dir in ("bin","include","lib","share","template"))
    {
        New-Item -ItemType Directory -Path php-sdk\PHP-$phpversion\$arch\$vs\deps\$Dir
    } 
    
Write-Output "Install PHP SRC $phpversion  ..."
$temp = New-TemporaryFile | Rename-Item -NewName {$_.Name + ".zip"} -PassThru
$urlsrc = "https://github.com/php/php-src/archive/refs/heads/PHP-$phpversion.zip";
Invoke-WebRequest $urlsrc -OutFile $temp
Expand-Archive $temp -DestinationPath "php-sdk\PHP-$phpversion\$arch\$vs\"
Rename-Item -Path "php-sdk\PHP-$phpversion\$arch\$vs\php-src-PHP-$phpversion" "PHP-$phpversion"

Write-Output "Install PHP $phpversion ..."

$temp = New-TemporaryFile | Rename-Item -NewName {$_.Name + ".zip"} -PassThru
$fname = "php-$phpversion-$tspart-$vs-$arch.zip"
$url = "$baseurl/$fname"
Invoke-WebRequest $url -OutFile $temp
Expand-Archive $temp "php-bin"
    
Write-Output "Install development pack ..."

$temp = New-TemporaryFile | Rename-Item -NewName {$_.Name + ".zip"} -PassThru
$fname = "php-devel-pack-$phpversion-$tspart-$vs-$arch.zip"
$url = "$baseurl/$fname"
Invoke-WebRequest $url -OutFile $temp
Expand-Archive $temp "."
Rename-Item "php-$phpversion-devel-$vs-$arch" "php-dev"