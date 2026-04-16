#!/bin/bash
# Экипаж — запуск (Linux)

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# CLI-варианты (на Linux обычно устанавливаются в PATH)
if command -v cursor >/dev/null 2>&1; then
  cursor "$DIR"
  exit 0
fi

if command -v code >/dev/null 2>&1; then
  code "$DIR"
  exit 0
fi

# Проверяем стандартные пути установки
for candidate in \
  "/usr/bin/cursor" \
  "/opt/cursor/cursor" \
  "$HOME/.local/bin/cursor" \
  "/snap/bin/cursor" \
  "/var/lib/flatpak/app/com.cursor.Cursor/current/active/export/bin/com.cursor.Cursor" \
  "/usr/bin/code" \
  "/snap/bin/code"; do
  if [ -x "$candidate" ]; then
    "$candidate" "$DIR"
    exit 0
  fi
done

echo "Cursor или VS Code не найдены."
echo "Скачать: https://cursor.com или https://code.visualstudio.com"
echo ""
echo "Запускаю Claude Code в этом терминале..."
echo ""

if command -v claude >/dev/null 2>&1; then
  claude -c
else
  echo "Claude Code тоже не найден в PATH."
  echo "Установить: https://docs.anthropic.com/en/docs/claude-code/quickstart"
  read -n 1 -s -r -p "Нажми любую клавишу для выхода..."
fi
