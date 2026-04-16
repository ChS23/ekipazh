# Экипаж — запуск (Windows)
# Открывает Cursor в папке бизнеса. Fallback: VS Code или Claude Code в терминале.

Set-Location $PSScriptRoot

if (Get-Command cursor -ErrorAction SilentlyContinue) {
    Start-Process cursor -ArgumentList $PSScriptRoot
}
elseif (Get-Command code -ErrorAction SilentlyContinue) {
    Start-Process code -ArgumentList $PSScriptRoot
}
else {
    Write-Host "Cursor или VS Code не найдены. Запускаю Claude Code в терминале."
    claude -c
}
