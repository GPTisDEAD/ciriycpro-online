# 07 — Сборка выставочного стенда (timelapse)

**Приоритет:** ⚡ 7
**Куда:** Карточка кейса §8.3 (hero страницы кейса), для /dlya-meropriyatiy/.
**Длина:** 8 секунд.

## Промпт для Gemini Veo (копируй целиком)

```
Generate ONE single continuous shot with internal timelapse motion.
No scene cuts between separate clips — just time acceleration within
the same locked camera frame.

Documentary-style 8-second timelapse clip. Fixed camera wide shot of a
convention hall section at Moscow Expocentre. Over 8 seconds, a bare
metal frame transforms into a fully assembled exhibition booth with
white panels, a desk, two chairs, ambient LED lighting. Four worker
silhouettes blur in and out of frame during the timelapse, their orange
helmets briefly visible. End frame: fully built booth, warm hall
lighting. Industrial realistic.

Aspect: 16:9. 1080p. 8 seconds.

Negative: no faces visible, no logos on booth, no visible text or
branding, no cartoon,
no scene transition BETWEEN DIFFERENT SCENES,
no mixing with other activities (no demolition, no cleaning, no unloading),
single continuous locked camera position — only time accelerates.
```

## Проверка результата

- Камера зафиксирована, меняется только то что в кадре?
- От пустого каркаса до готового стенда — одно место?
- Силуэты рабочих в движении, оранжевые каски мелькают?
- Нет кадров монтажа из других сцен?

Если «нет» хоть на один пункт — regenerate. Timelapse — сложный жанр для Veo, может понадобиться 2-3 попытки.
