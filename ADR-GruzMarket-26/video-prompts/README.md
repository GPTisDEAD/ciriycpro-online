# Видео-промпты для Gemini Veo — GruzMarket77

Каждый клип — **отдельный файл**. Копируй **содержимое ОДНОГО файла целиком** в Gemini Veo. Так Gemini не склеивает сцены между собой (баг «клининг + разгрузка в одном видео» уходит).

## Приоритет и порядок генерации

| № | Файл | Сцена | Приоритет | Куда |
|---|---|---|---|---|
| 01 | `01-hero-razgruzka.md` | Разгрузка фуры бригадой 6-8 чел | 🔥 1 | Hero главной |
| 02 | `02-demontazh.md` | Удар кувалдой + пыль | 🔥 2 | /uslugi/demontazh/ |
| 03 | `03-klining.md` | Швабра контраст до/после | 🔥 3 | /uslugi/uborka-posle-remonta/ |
| 04 | `04-pogruzka-musora.md` | Конвейер людей → контейнер | ⭐ 4 | /uslugi/demontazh/ |
| 05 | `05-shpaklevka.md` | Шпатель, диагональные мазки | ⭐ 5 | /uslugi/otdelochnye-raboty/ |
| 06 | `06-moyka-okon.md` | Промальп на мирроре | ⭐ 6 | /uslugi/mytyo-okon/ |
| 07 | `07-stend.md` | Timelapse сборки стенда | ⚡ 7 | кейс §8.3 |
| 08 | `08-plitka.md` | Укладка плитки, руки сверху | ⚡ 8 | /uslugi/otdelka-pod-klyuch/ |
| 09 | `09-elektrika.md` | Кабель в штробу | бонус | /uslugi/elektrika-santekhnika/ |
| 10 | `10-styazhka.md` | Правило по стяжке | бонус | /uslugi/monolit-styazhka/ |
| 11 | `11-sneg.md` | Уборка снега на парковке | бонус | /uslugi/uborka-territoriy/ |

## Если бюджет Gemini кончается — приоритет

1. **01-hero-razgruzka.md** (hero главной — самый ценный)
2. **03-klining.md** (убеждает мгновенно, wow)
3. **02-demontazh.md** (эмоция, запоминается)
4. **05-shpaklevka.md** (для /dlya-prorabov/)

Остальное — реальные съёмки от Таирова, когда появятся.

## Правило против двойных видео

**Не копируй два промпта подряд в одно окно Gemini.** После каждой генерации — **новая сессия / новый чат** в Gemini. Иначе он подхватывает контекст предыдущего промпта и смешивает сцены.

Технически в каждый промпт вшито:
```
Negative: no scene transition, no cuts, no multiple scenes,
no before-after montage with different activities,
single continuous shot only.
```

Если Gemini всё равно клеит — добавь в начало промпта: `Generate ONE single continuous shot. No montage.`

## Что станет на сайт

Готовые клипы сохраняй в `site/public/video/`:
- `hero.mp4` + `hero.webm` — главная
- `uslugi/demontazh.mp4`, `uslugi/klining.mp4` и т.д.

Скажешь — одним коммитом подключу `<video autoplay muted loop playsinline poster="...">` с `prefers-reduced-motion` и lazy-load.

## Общие технические правила (встроены в каждый промпт)

- **Длина**: 5–8 секунд, loop-friendly
- **Разрешение**: 1920×1080
- **Стиль**: documentary industrial, 35mm, естественный свет
- **Палитра**: graphite + warm orange accent
- **Без лиц**: силуэты со спины, руки в перчатках, вид сверху
