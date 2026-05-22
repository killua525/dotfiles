Param(
  [string]$RepoDir = "$HOME\dotfiles",
  [switch]$Help
)

$ErrorActionPreference = "Stop"

function Say([string]$msg) { Write-Host $msg }

function Usage() {
  @"
Usage: powershell -ExecutionPolicy Bypass -File tools\windows\setup.ps1 [-RepoDir PATH]

Install dotfiles by linking repository files into the Windows user profile.
Directory targets use symlinks when possible and junctions as a link fallback.
No config files are copied.
"@ | Write-Host
}

if ($Help) {
  Usage
  exit 0
}

function Backup-IfExists([string]$Path) {
  if (Test-Path $Path) {
    $n = 0
    while (Test-Path "$Path.bak$n") { $n++ }
    $backup = "$Path.bak$n"
    Say "[backup] $Path -> $backup"
    Move-Item -Force $Path $backup
    return $backup
  }
  return $null
}

function Restore-Backup([string]$Path, [string]$Backup) {
  if ($Backup -and (Test-Path $Backup) -and -not (Test-Path $Path)) {
    Move-Item -Force $Backup $Path
    Say "[restore] $Backup -> $Path"
  }
}

function Try-Link([string]$Src, [string]$Dst) {
  $backup = $null
  try {
    $backup = Backup-IfExists $Dst
    New-Item -ItemType SymbolicLink -Path $Dst -Target $Src | Out-Null
    Say "[link] $Dst -> $Src"
    return $true
  } catch {
    Restore-Backup $Dst $backup
    return $false
  }
}

function Try-Junction([string]$Src, [string]$Dst) {
  $backup = $null
  try {
    $backup = Backup-IfExists $Dst
    New-Item -ItemType Junction -Path $Dst -Target $Src | Out-Null
    Say "[junction] $Dst -> $Src"
    return $true
  } catch {
    Restore-Backup $Dst $backup
    return $false
  }
}

function Link-Item([string]$Src, [string]$Dst) {
  if (-not (Test-Path $Src)) {
    Say "[skip] missing in repo: $Src"
    return
  }
  $parent = Split-Path -Parent $Dst
  if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Force $parent | Out-Null }

  if (Try-Link $Src $Dst) { return }
  if (Test-Path $Src -PathType Container) {
    if (Try-Junction $Src $Dst) { return }
  }

  throw "Unable to create link for $Dst. Enable Developer Mode or run PowerShell as Administrator."
}

function Assert-Cmd([string]$cmd) {
  $p = Get-Command $cmd -ErrorAction SilentlyContinue
  if (-not $p) { throw "Required command not found: $cmd" }
}

Assert-Cmd git

if (-not (Test-Path $RepoDir)) {
  Say "[git] cloning into $RepoDir"
  git clone https://github.com/killua525/dotfiles.git $RepoDir
}

Set-Location $RepoDir

if (Test-Path ".git") {
  Say "[git] fetch --all --prune"
  git fetch --all --prune | Out-Null
  Say "[git] pull --rebase --autostash"
  git pull --rebase --autostash | Out-Null
}

$repo = (Get-Location).Path
$home = $HOME
$localAppData = $env:LOCALAPPDATA
if (-not $localAppData) {
  $localAppData = Join-Path $home "AppData\Local"
}

Say "[info] repo: $repo"
Say "[info] home: $home"

Link-Item (Join-Path $repo ".gitconfig") (Join-Path $home ".gitconfig")
Link-Item (Join-Path $repo ".gitignore") (Join-Path $home ".gitignore")
Link-Item (Join-Path $repo ".tigrc")     (Join-Path $home ".tigrc")

Link-Item (Join-Path $repo ".vim") (Join-Path $home "vimfiles")
Link-Item (Join-Path $repo "tools\windows\_vimrc")  (Join-Path $home "_vimrc")
Link-Item (Join-Path $repo "tools\windows\_gvimrc") (Join-Path $home "_gvimrc")
Link-Item (Join-Path $repo "config\nvim") (Join-Path $localAppData "nvim")

Say "Done."
