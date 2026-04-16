# Экипаж — плагин для Claude Code

ИИ-система для экспертов и самозанятых.

## Как это работает

Плагин предоставляет:
- **Output style** (`output-styles/ekipazh.md`) — заменяет coding-часть системного промпта CC на бизнес-харнесс
- **Скиллы** (`skills/`) — `/start`, `/analyze`, `/rule`, `/post`, `/kp`, `/objection`, `/status`, `/format`, `/workflow`
- **Субагенты** (`agents/`) — interviewer, analyst, operator для делегирования

## Активация

1. `claude --plugin-dir /home/chs/github/ekipazh/`
2. `/config` → Output style → выбрать **Экипаж**
3. Перезапустить сессию

После этого Claude Code работает как Экипаж: бизнес-ассистент, не кодинг.

## Для разработки

- Перезагрузка без рестарта: `/reload-plugins`
- Тест скиллов: `/help` покажет все доступные
- Структура артефактов пользователя: `профиль/`, `анализ/`, `правила/`, `контент/`, `решения/`

## Архитектура

```
ekipazh/
├── CLAUDE.md                     ← этот файл (документация)
├── .claude-plugin/plugin.json    ← манифест
├── output-styles/
│   └── ekipazh.md                ← system prompt для Экипажа
├── agents/                       ← 3 субагента
├── skills/                       ← 9 скиллов
└── templates/                    ← шаблоны артефактов
```
