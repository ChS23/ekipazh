#!/bin/bash
# Проверяем активирован ли output style "Экипаж"
# Если нет — просим Claude напомнить пользователю

STYLE=""
for SETTINGS in ".claude/settings.local.json" ".claude/settings.json" "$HOME/.claude/settings.json"; do
  if [ -f "$SETTINGS" ]; then
    FOUND=$(grep -o '"outputStyle"[[:space:]]*:[[:space:]]*"[^"]*"' "$SETTINGS" 2>/dev/null | head -1 | sed 's/.*"\([^"]*\)"$/\1/')
    if [ -n "$FOUND" ]; then
      STYLE="$FOUND"
      break
    fi
  fi
done

if [ "$STYLE" = "Экипаж" ]; then
  exit 0
fi

cat <<'EOF'
Плагин Экипаж загружен, но output style не активирован.

Скажи пользователю (ровно так, коротко):

"Плагин Экипаж подключён, но работает пока как обычный Claude Code.
Чтобы включить режим бизнес-ассистента:
1. /config → Output style → Экипаж
2. Перезапусти сессию

После этого я буду работать как твоя ИИ-команда."

Не добавляй ничего от себя. Жди действий пользователя.
EOF
exit 0
