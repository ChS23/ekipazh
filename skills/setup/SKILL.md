---
name: setup
description: Настройка рабочего окружения — копирует скрипт запуска в папку бизнеса, создаёт .vscode/tasks.json для авто-запуска Claude Code при открытии в Cursor/VS Code, объясняет как сделать ярлык. Используй когда пользователь говорит "как удобнее запускать", "сделай ярлык", "как каждый день открывать", или при первой настройке после /start.
allowed-tools: Read, Write, Bash
---

# Настройка рабочего окружения

Цель: юзер кликает на один ярлык → открывается Cursor в папке бизнеса → терминал с `claude -c` запускается сам → работа начата.

## Когда включается

- Первая настройка после `/start`
- Пользователь спрашивает "как удобнее каждый день открывать"
- Просит ярлык, иконку, быстрый запуск

## Что делать

### 1. Определи ОС

```
!`uname -s 2>/dev/null || ver`
```

- `Darwin` → macOS
- `Linux` → Linux
- `Microsoft Windows` или вывод `ver` → Windows

### 2. Скопируй скрипт запуска

Из плагина в рабочую папку юзера:

| ОС | Откуда | Куда |
|----|--------|------|
| macOS | `${CLAUDE_PLUGIN_ROOT}/scripts/start.command` | `./start.command` |
| Linux | `${CLAUDE_PLUGIN_ROOT}/scripts/start.sh` | `./start.sh` |
| Windows | `${CLAUDE_PLUGIN_ROOT}/scripts/start.ps1` | `./start.ps1` |

На Unix: `chmod +x start.*` после копирования.

Скрипт открывает Cursor (или VS Code как fallback) в папке бизнеса. Если ни одного нет — запустит Claude Code в терминале напрямую.

### 3. Создай .vscode/tasks.json для авто-запуска

Создай в рабочей папке `./.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Экипаж",
      "type": "shell",
      "command": "claude",
      "args": ["-c"],
      "presentation": {
        "echo": false,
        "reveal": "always",
        "focus": true,
        "panel": "shared"
      },
      "runOptions": {
        "runOn": "folderOpen"
      },
      "problemMatcher": []
    }
  ]
}
```

И `./.vscode/settings.json`:

```json
{
  "task.allowAutomaticTasks": "on",
  "files.exclude": {
    ".vscode": true,
    ".claude": true
  }
}
```

Это заставит Cursor/VS Code при открытии папки автоматически запускать терминал с `claude -c`.

**Важно:** при первом открытии папки в Cursor/VS Code появится prompt "Allow automatic tasks" — юзеру надо нажать **Allow**. Один раз.

### 4. Объясни как сделать ярлык на рабочем столе

**macOS:**
```
1. Открой Finder в папке бизнеса
2. Правый клик на start.command → Создать псевдоним
3. Перетащи псевдоним на рабочий стол
4. Переименуй в "Экипаж"
```

**Windows:**
```
1. Правый клик на рабочем столе → Создать → Ярлык
2. В поле "Расположение":
   powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\полный\путь\start.ps1"
3. Имя ярлыка: "Экипаж"
```

**Linux:**
```
Создай ~/.local/share/applications/ekipazh.desktop:

[Desktop Entry]
Type=Application
Name=Экипаж
Exec=/полный/путь/start.sh
Terminal=false
Icon=utilities-terminal
```

### 5. Подтверждение

```
Настройка готова ✓

Что теперь каждый день:
1. Клик на "Экипаж" на рабочем столе
2. Открывается Cursor в папке твоего бизнеса
3. Автоматически запускается терминал с Claude Code
4. Начинаешь говорить (/voice для голосового ввода)

Всё. Никаких команд, никакого терминала руками.
```

## Если Cursor/VS Code не установлены

Предложи установить Cursor: https://cursor.com (рекомендую) или VS Code: https://code.visualstudio.com

Объясни:
- Cursor/VS Code — это IDE, но ты его используешь как просмотрщик файлов и терминал
- Код не пишешь, тебе нужны только левая колонка (файлы) и терминал снизу
- AI-функции Cursor можно отключить чтобы не путать с Claude Code

## Важно

- Не перезаписывай существующие start.*, .vscode/tasks.json — спроси юзера
- Если нет прав на запись — дай инструкцию скопировать вручную
- Объясни что trust workspace prompt при первом открытии — это нормально, надо один раз Allow
