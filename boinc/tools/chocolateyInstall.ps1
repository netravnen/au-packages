$packageName = 'boinc'
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$url32 = 'https://boinc.berkeley.edu/dl/boinc_7.16.3_windows_intelx86.exe'
$checksum32 = '83c1cd6d0a90a170aca746b12a42b29377e4b419c2b13b1b2bf6dc28dd91e79d'
$checksumType32 = 'sha256'
$url64 = 'https://boinc.berkeley.edu/dl/boinc_7.16.5_windows_x86_64.exe'
$checksum64 = '39598788e8bcee0f5b11e16baab4cad8af9dce7c9d6464642cfe82656d9b23a3'
$checksumType64 = 'sha256'
$validExitCodes = @(0)
$ErrorActionPreference = 'Stop'

$packageArgs = @{
  PackageName    = $packageName
  FileType       = $installerType
  SilentArgs     = $silentArgs
  Url            = $url32
  Url64bit       = $url64
  ValidExitCodes = $validExitCodes
  Checksum       = $checksum32
  ChecksumType   = $checksumType32
  Checksum64     = $checksum64
  ChecksumType64 = $checksumType64
}

Install-ChocolateyPackage @packageArgs
