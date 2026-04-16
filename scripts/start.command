#!/bin/bash
# Экипаж — запуск (macOS)

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Пробуем Cursor через open (не требует CLI в PATH)
if [ -d "/Applications/Cursor.app" ]; then
  open -a "Cursor" "$DIR"
  exit 0
fi

# Fallback на VS Code
if [ -d "/Applications/Visual Studio Code.app" ]; then
  open -a "Visual Studio Code" "$DIR"
  exit 0
fi

# CLI-варианты
if command -v cursor >/dev/null 2>&1; then
  cursor "$DIR"
  exit 0
fi

if command -v code >/dev/null 2>&1; then
  code "$DIR"
  exit 0
fi

# Последний fallback — просто терминал с Claude Code
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
