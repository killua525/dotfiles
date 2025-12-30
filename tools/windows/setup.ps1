Param(
  [string]$RepoDir = "$HOME\dotfiles"
)

$ErrorActionPreference = "Stop"

function Say([string]$msg) { Write-Host $msg }

function Backup-IfExists([string]$Path) {
  if (Test-Path $Path) {
    $n = 0
    while (Test-Path "$Path.bak$n") { $n++ }
    Say "[backup] $Path -> $Path.bak$n"
    Move-Item -Force $Path "$Path.bak$n"
  }
}

function Try-Link([string]$Src, [string]$Dst) {
  try {
    Backup-IfExists $Dst
    New-Item -ItemType SymbolicLink -Path $Dst -Target $Src | Out-Null
    Say "[link] $Dst -> $Src"
    return $true
  } catch {
    return $false
  }
}

function Try-Junction([string]$Src, [string]$Dst) {
  try {
    Backup-IfExists $Dst
    New-Item -ItemType Junction -Path $Dst -Target $Src | Out-Null
    Say "[junction] $Dst -> $Src"
    return $true
  } catch {
    return $false
  }
}

function Copy-Any([string]$Src, [string]$Dst) {
  Backup-IfExists $Dst
  if (Test-Path $Src -PathType Container) {
    Copy-Item -Recurse -Force $Src $Dst
  } else {
    Copy-Item -Force $Src $Dst
  }
  Say "[copy] $Dst <= $Src"
}

function Link-Or-Copy([string]$Src, [string]$Dst) {
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
  Copy-Any $Src $Dst
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

Say "[info] repo: $repo"
Say "[info] home: $home"

Link-Or-Copy (Join-Path $repo ".gitconfig") (Join-Path $home ".gitconfig")
Link-Or-Copy (Join-Path $repo ".gitignore") (Join-Path $home ".gitignore")
Link-Or-Copy (Join-Path $repo ".tigrc")     (Join-Path $home ".tigrc")

Link-Or-Copy (Join-Path $repo ".vim") (Join-Path $home "vimfiles")
Link-Or-Copy (Join-Path $repo "tools\windows\_vimrc")  (Join-Path $home "_vimrc")
Link-Or-Copy (Join-Path $repo "tools\windows\_gvimrc") (Join-Path $home "_gvimrc")

Say "Done."
