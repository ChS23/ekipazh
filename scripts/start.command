#!/bin/bash
# Экипаж — запуск (macOS)
# Открывает Cursor в папке бизнеса. Если Cursor не установлен, падает на VS Code или терминал.

DIR="$(dirname "$0")"
cd "$DIR"

if command -v cursor >/dev/null 2>&1; then
  cursor "$DIR"
elif command -v code >/dev/null 2>&1; then
  code "$DIR"
else
  echo "Cursor или VS Code не найдены. Запускаю Claude Code в терминале."
  claude -c
fi
