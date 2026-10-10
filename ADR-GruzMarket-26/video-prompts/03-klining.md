# 03 — Клининг. Контраст до/после одним движением швабры

**Приоритет:** 🔥 3
**Куда:** Hero страницы /uslugi/uborka-posle-remonta/, в карточке услуги на главной.
**Длина:** 5 секунд.

## Промпт для Gemini Veo (копируй целиком)

```
Generate ONE single continuous shot. No montage, no scene cuts.

Documentary-style 5-second cinematic clip. Top-down overhead shot of a
Moscow office floor covered in grey construction dust. A professional
microfiber mop with orange handle slides across the frame left to right
in one smooth continuous motion. In its path, the floor transforms
instantly from dusty grey to spotless glossy laminate reflecting ceiling
lights. Clean, satisfying, before-after visualization within one single
continuous camera shot (NOT a cut between two scenes). Camera locked
overhead. Natural daylight.

Aspect: 16:9. 1080p. 5 seconds.

Negative: no faces, no people visible, no mop handle holder shown,
no logos, no text overlays, no cartoon, no cgi,
no scene transition, no hard cut between before and after,
no multiple scenes, no second clip, no split frame, no montage,
no mixing with other activities (no demolition, no unloading, no construction),
single continuous shot only — the floor changes within the shot,
camera never cuts away.
```

## Проверка результата

- Один непрерывный кадр сверху? (НЕ склейка «грязный → чистый» двумя кадрами)
- Пол меняется в кадре под шваброй?
- Швабра с оранжевой ручкой?
- Нет видимых рук/людей (только швабра)?

Если «нет» хоть на один пункт — regenerate. Это самый сложный клип для Gemini, может потребоваться 2-3 попытки.
