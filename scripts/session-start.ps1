# Проверяем активирован ли output style "Экипаж"

$style = $null
$paths = @(
    ".claude/settings.local.json",
    ".claude/settings.json",
    Join-Path $HOME ".claude/settings.json"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -ErrorAction SilentlyContinue
        if ($content -match '"outputStyle"\s*:\s*"([^"]*)"') {
            $style = $matches[1]
            break
        }
    }
}

if ($style -eq "Экипаж") {
    exit 0
}

@"
Плагин Экипаж загружен, но output style не активирован.

Скажи пользователю (ровно так, коротко):

"Плагин Экипаж подключён, но работает пока как обычный Claude Code.
Чтобы включить режим бизнес-ассистента:
1. /config → Output style → Экипаж
2. Перезапусти сессию

После этого я буду работать как твоя ИИ-команда."

Не добавляй ничего от себя. Жди действий пользователя.
"@

exit 0
