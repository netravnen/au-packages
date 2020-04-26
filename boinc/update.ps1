import-module au

$releases = 'https://boinc.berkeley.edu/dl/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
      "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_GetLatest {
  $re1 = '^boinc_.+_windows_.+\.exe$' # Get boinc dl links
  $re2 = '^boinc_.+_windows_.+vbox\.exe$' # exclude virtualbox dl link
  $re32 = '^boinc_.+_windows_intelx86.exe$'
  $re64 = '^boinc_.+_windows_x86_64.exe$'
  
  $download_page = $(Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | ? href -match $re1 | ? href -notmatch $re2
  
  $url32 = $download_page | ? href -match $re32 | select -Last 1 -expand href
  $url64 = $download_page | ? href -match $re64 | select -Last 1 -expand href
  
  $version = $url64 -split '_' | select -Index 1

  $Latest = @{
    URL32        = $releases + $url32
    URL64        = $releases + $url64
    Version      = $version
  }
  
  return $Latest
}

update
