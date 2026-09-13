# tool/portao.ps1 — Portão, fase 1. Comando único, mesmo conjunto que o CI roda.
#
#   pwsh -File tool\portao.ps1        (ou)   powershell -File tool\portao.ps1
#
# Sai com 0 só se os quatro comandos passarem. Para no primeiro que falhar:
# portão que segue depois de falhar esconde a causa real atrás do próximo erro.

$ErrorActionPreference = 'Stop'

$raiz = Split-Path -Parent $PSScriptRoot
$app  = Join-Path $raiz 'app'

if (-not (Test-Path (Join-Path $app 'pubspec.yaml'))) {
    Write-Host "ERRO: nao encontrei app/pubspec.yaml em $app" -ForegroundColor Red
    exit 1
}

# A JDK 25 da maquina e nova demais para o Gradle que o Flutter gera (ver D-006).
$jdk17 = Get-ChildItem 'C:\Program Files\Microsoft\jdk-17*' -Directory -ErrorAction SilentlyContinue |
         Select-Object -First 1
if ($jdk17) { $env:JAVA_HOME = $jdk17.FullName }

$passos = @(
    @{ nome = 'flutter analyze';                 exe = 'flutter'; args = @('analyze', '--fatal-infos', '--fatal-warnings') },
    @{ nome = 'dart format --set-exit-if-changed'; exe = 'dart';  args = @('format', '--set-exit-if-changed', '.') },
    @{ nome = 'flutter test';                    exe = 'flutter'; args = @('test') },
    @{ nome = 'flutter build apk --debug';       exe = 'flutter'; args = @('build', 'apk', '--debug') }
)

Push-Location $app
try {
    Write-Host "=== flutter pub get ===" -ForegroundColor Cyan
    & flutter pub get
    if ($LASTEXITCODE -ne 0) { Write-Host "PORTAO VERMELHO: pub get" -ForegroundColor Red; exit 1 }

    foreach ($p in $passos) {
        Write-Host ""
        Write-Host "=== $($p.nome) ===" -ForegroundColor Cyan
        & $p.exe @($p.args)
        if ($LASTEXITCODE -ne 0) {
            Write-Host ""
            Write-Host "PORTAO VERMELHO em: $($p.nome)  (exit $LASTEXITCODE)" -ForegroundColor Red
            exit $LASTEXITCODE
        }
    }
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "PORTAO VERDE - os quatro passos passaram." -ForegroundColor Green
exit 0
