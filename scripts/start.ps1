# Экипаж — запуск (Windows)

$ErrorActionPreference = "Continue"
Set-Location $PSScriptRoot

function Start-IDE {
    param([string]$Path)

    # Пробуем CLI
    if (Get-Command cursor -ErrorAction SilentlyContinue) {
        Start-Process cursor -ArgumentList "`"$Path`""
        return $true
    }
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Start-Process code -ArgumentList "`"$Path`""
        return $true
    }

    # Стандартные пути установки Cursor
    $cursorPaths = @(
        "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
        "$env:LOCALAPPDATA\Programs\Cursor\Cursor.exe",
        "${env:ProgramFiles}\Cursor\Cursor.exe"
    )
    foreach ($p in $cursorPaths) {
        if (Test-Path $p) {
            Start-Process $p -ArgumentList "`"$Path`""
            return $true
        }
    }

    # Стандартные пути VS Code
    $codePaths = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
        "${env:ProgramFiles}\Microsoft VS Code\Code.exe"
    )
    foreach ($p in $codePaths) {
        if (Test-Path $p) {
            Start-Process $p -ArgumentList "`"$Path`""
            return $true
        }
    }

    return $false
}

$launched = Start-IDE -Path $PSScriptRoot

if (-not $launched) {
    Write-Host "Cursor или VS Code не найдены."
    Write-Host "Скачать: https://cursor.com или https://code.visualstudio.com"
    Write-Host ""
    Write-Host "Запускаю Claude Code в этом терминале..."
    Write-Host ""

    if (Get-Command claude -ErrorAction SilentlyContinue) {
        claude -c
    } else {
        Write-Host "Claude Code тоже не найден в PATH."
        Write-Host "Установить: https://docs.anthropic.com/en/docs/claude-code/quickstart"
        Write-Host ""
        Read-Host "Нажми Enter для выхода"
    }
}
