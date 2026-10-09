# AI-видео промпты для Gemini Veo — GruzMarket77

> Для генерации в **Gemini Veo 3** (Google AI Studio → Video) или **Veo 3 API**.
> Короткие клипы **5–8 секунд, 720p/1080p**, обычно ~$0.10–0.30 за клип.
> На твои $5 можно сгенерить ~15–30 клипов — хватит с запасом на всё с перегенерацией.

---

## Что продаёт лучше — коммерческий отбор

Не всё одинаково полезно. Из твоего списка я отбросил «просто делают», «устанавливают», «собирают мебель» — слабая демонстрация ценности, зрителю не понятно за что он платит.

**Что реально продаёт в B2B-аутстаффинге (ранжировано):**

| Приоритет | Сцена | Куда на сайт | Почему продаёт |
|---|---|---|---|
| 🔥 **1** | Разгрузка фуры **бригадой из 6-8 человек** | Hero главной | «Много людей = проблема решается быстро» — главный страх прораба |
| 🔥 **2** | Демонтаж стены **кувалдой** + падение + пыль | /uslugi/demontazh/ hero | Эмоциональный хук, демонстрирует силу и опыт |
| 🔥 **3** | Клининг-контраст **до/после** одним движением швабры | /uslugi/uborka-posle-remonta/ hero | Классика «wow»: за 5 секунд виден результат |
| ⭐ **4** | Погрузка строймусора в контейнер **конвейером** | /uslugi/demontazh/ или кейс | Доказывает тезис «вывоз мусора входит» |
| ⭐ **5** | Шпаклёвка стены медитативным движением | /uslugi/otdelochnye-raboty/ | Транслирует «аккуратность, качество» |
| ⭐ **6** | Мойка панорамных окон с верёвок | /uslugi/mytyo-okon/ | Редкий эффектный ракурс, визуальная ценность |
| ⚡ **7** | Сборка выставочного стенда timelapse | Кейс §8.3 | Для ивент-агентств — «мы можем много» |
| ⚡ **8** | Укладка плитки крупно руками в оранжевых перчатках | /uslugi/otdelka-pod-klyuch/ | Доверие к мастерству |

---

## Технические правила (вшиты в каждый промпт)

- **Длина**: 5–8 секунд, зацикленные (loop-friendly начало/конец похожи)
- **Разрешение**: 1920×1080 для десктопа, автоматически даунскейлится мобилкой
- **Стиль**: documentary industrial, 35mm feel, естественный свет
- **Палитра**: graphite tones + warm orange accent (каска/перчатка/жилет/контейнер)
- **Без лиц**: силуэты со спины, руки в перчатках, вид сверху, dutch angle
- **Негатив**: `no faces, no corporate logos, no text overlays, no watermark, no slow pan to selling text`

---

## Промпты (11 клипов)

### 🔥 1. HERO главной — Разгрузка фуры бригадой

```
Documentary-style 7-second cinematic clip. Wide low-angle shot of a
Moscow logistics yard at golden hour. A team of six workers in orange
hi-vis vests and helmets, seen from behind, forming a chain unloading
cardboard pallets from the back of a large truck. Steady synchronized
movement, dust floating in the warm orange light, slight motion blur
on hands. Camera static, locked wide shot. Industrial realistic,
no music, no faces visible. Loop-ready start and end.

Aspect: 16:9. 1080p. 7 seconds.

Negative: no faces, no logos on vests or truck, no text overlays,
no cartoon, no 3d render, no stock smile.
```

**Где вставить:** Hero главной, фоном за формой заявки, autoplay muted loop.

---

### 🔥 2. ДЕМОНТАЖ — удар кувалдой по стене

```
Documentary-style 6-second clip. Medium close-up shot of a muscular
arm in a dusty orange work glove swinging a heavy sledgehammer at a
plasterboard wall. Impact: wall cracks, plaster chunks fall, grey dust
cloud explodes outward in slow motion for the last 2 seconds. Shaky
handheld camera. Dusty daylight through an uncovered apartment window.
Graphite concrete floor visible. Realistic, no music.

Aspect: 16:9. 1080p. 6 seconds.

Negative: no face, no body shown above shoulder, no logos, no text,
no cartoon, no cgi dust.
```

**Где вставить:** Hero страницы /uslugi/demontazh/, muted autoplay с опцией "repeat".

---

### 🔥 3. КЛИНИНГ — контраст до/после одним движением

```
Documentary-style 5-second cinematic clip. Top-down overhead shot of a
Moscow office floor covered in grey construction dust. A professional
microfiber mop with orange handle slides across the frame left to right
in one smooth continuous motion. In its path, the floor transforms
instantly from dusty grey to spotless glossy laminate reflecting ceiling
lights. Clean, satisfying, before-after visualization. Camera locked
overhead. Natural daylight.

Aspect: 16:9. 1080p. 5 seconds.

Negative: no faces, no people visible, no mop handle holder shown,
no logos, no text overlays, no cartoon, no cgi.
```

**Где вставить:** Hero страницы /uslugi/uborka-posle-remonta/, в карточке услуги на главной.

---

### ⭐ 4. ПОГРУЗКА мусора в контейнер — конвейер людей

```
Documentary-style 6-second clip. Wide shot of an open-air site next to
a residential Moscow building. A team of four workers in orange vests,
seen from behind, forming a short chain tossing construction debris
bags into a large yellow-orange 8m³ dumpster container. Rhythmic
coordinated movement, dust particles catching afternoon light,
sledgehammer leaning against the container as a prop. Industrial
realistic, no music, no faces.

Aspect: 16:9. 1080p. 6 seconds.

Negative: no faces, no corporate logos on vests or container, no text,
no cartoon, no stock smile.
```

**Где вставить:** В секцию «что входит» на /uslugi/demontazh/, или на карточке кейса §8.1.

---

### ⭐ 5. ШПАКЛЁВКА — ритмичное движение шпателем

```
Documentary-style 7-second close-up clip. Hands in orange work gloves
spreading smooth white plaster on a bare grey concrete wall with a
wide stainless steel putty knife. Three precise diagonal strokes
in sequence, meditative rhythm, fresh plaster texture visible, warm
side lighting creating subtle shadows on the strokes. Natural daylight
from the right. Realistic, no music.

Aspect: 16:9. 1080p. 7 seconds.

Negative: no face, no body above wrists, no logos, no text,
no cartoon, no cgi, no obvious loop cut.
```

**Где вставить:** Hero /uslugi/otdelochnye-raboty/, или в секцию «что входит».

---

### ⭐ 6. МОЙКА панорамных окон с верёвок

```
Documentary-style 6-second clip. Low-angle wide shot looking up a
mirror-glass skyscraper facade in Moscow. A single industrial climber
in orange harness and helmet, seen from below as a small silhouette,
rappels down the glass with a professional window squeegee leaving a
clear trail on the dusty window. Blue sky reflection in the glass.
Steady vertical camera motion following down 2 meters. Realistic,
no music.

Aspect: 16:9. 1080p. 6 seconds.

Negative: no face, no corporate logos on building, no text,
no cartoon, no fake cgi reflection.
```

**Где вставить:** Hero /uslugi/mytyo-okon/, впечатляет сразу.

---

### ⚡ 7. СБОРКА выставочного стенда — timelapse

```
Documentary-style 8-second timelapse clip. Fixed camera wide shot of a
convention hall section at Moscow Expocentre. Over 8 seconds, a bare
metal frame transforms into a fully assembled exhibition booth with
white panels, a desk, two chairs, ambient LED lighting. Four worker
silhouettes blur in and out of frame during the timelapse, their orange
helmets briefly visible. End frame: fully built booth, warm hall
lighting. Industrial realistic.

Aspect: 16:9. 1080p. 8 seconds.

Negative: no faces visible, no logos on booth, no visible text or
branding, no cartoon.
```

**Где вставить:** Карточка кейса §8.3 (hero страницы кейса), для /dlya-meropriyatiy/.

---

### ⚡ 8. УКЛАДКА плитки — руки в оранжевых перчатках

```
Documentary-style 6-second clip. Top-down close shot of two hands in
orange work gloves carefully placing a large grey porcelain tile onto a
freshly combed thinset bed, then pressing it precisely with a rubber
mallet. Spacer crosses visible beside. Natural warm bathroom lighting.
Satisfying click of alignment. Steady camera from directly above.
Realistic, no music.

Aspect: 16:9. 1080p. 6 seconds.

Negative: no face, no body above wrists, no logos on tiles or tools,
no text, no cartoon, no cgi.
```

**Где вставить:** /uslugi/otdelka-pod-klyuch/, или кейс §8.4 (санузел под ключ).

---

### Бонус-клипы (если останется бюджет на эксперименты)

### 9. ЭЛЕКТРИКА — руки прокладывают кабель в штробу

```
Documentary 5-second clip. Close shot of hands in orange gloves
pushing a thick electrical cable into a freshly cut vertical channel
in a bare concrete wall. Smooth continuous motion, small cable
loops at bottom of frame. Work light casts warm side glow. Realistic.

16:9. 1080p. 5 seconds.

Negative: no face, no logos, no text, no cartoon.
```

Для /uslugi/elektrika-santekhnika/.

### 10. СТЯЖКА — выравнивание бетона правилом

```
Documentary 6-second clip. Low wide shot of a bare apartment floor,
wet concrete screed just poured. A worker in orange hi-vis knee pads
and gloves, seen from behind, pulls a long aluminum straightedge
across the surface in one smooth motion, leveling the concrete.
Dusty daylight from a window. Realistic.

16:9. 1080p. 6 seconds.

Negative: no face, no logos, no text overlays, no cartoon.
```

Для /uslugi/monolit-styazhka/.

### 11. ТЕРРИТОРИЯ — зимняя уборка снега

```
Documentary 5-second clip. Early morning wide shot of a Moscow business
center parking lot covered in fresh snow. Two workers in orange hi-vis
jackets with industrial snow shovels, seen from behind, clearing a path
in synchronized rhythm. Breath visible in cold air, warm pink sunrise
light. Realistic, no music.

16:9. 1080p. 5 seconds.

Negative: no faces, no corporate logos, no text, no cartoon.
```

Для /uslugi/uborka-territoriy/ — зимняя версия (летнюю потом добавим).

---

## Как это встанет на сайт — технический план

Когда клипы будут готовы:

1. **Сохрани в WebM + MP4** (Gemini экспортит MP4, я добавлю WebM-версию через ffmpeg для веб-оптимизации)
2. **Кидай в** `site/public/video/`:
   - `hero.webm` + `hero.mp4` — главная
   - `uslugi/demontazh.mp4`, `uslugi/klining.mp4` и т.д.
3. Скажешь — я одним коммитом:
   - Заменю CSS-паттерн в hero на `<video autoplay muted loop playsinline poster="...jpg">` (poster — статичный превью на случай медленного инета)
   - Добавлю `prefers-reduced-motion` — для юзеров с отключённой анимацией покажу статик
   - Lazy-load на страницах услуг (видео загружается только когда юзер доскроллил)
   - Проверю что Lighthouse Performance не упал ниже 90 (контролирую вес видео: hero ≤2 МБ, уcлуги ≤1 МБ)

---

## Коммерческий совет

**Не ставь видео на ВСЕ 14 страниц услуг.** Это убьёт мобильный трафик (вес сайта вырастет в 5-10 раз). Правило:
- **Hero главной** — одно сильное видео (разгрузка фуры)
- **Hero 4–5 топ-услуг** (демонтаж, грузчики, клининг, отделка, окна) — одно видео на страницу
- **Остальные 9 услуг** — статичные фото из промптов для картинок

Это выдержит баланс «вау-эффект» vs «быстро грузится». И у тебя будет повод добавить видео в оставшиеся услуги во второй волне — как контент-апдейт после первых заявок.

---

## Если денег в Gemini хватит только на 3-4 клипа

Приоритет:
1. **Разгрузка фуры** (hero главной — самый ценный)
2. **Клининг-контраст** (убеждает мгновенно)
3. **Демонтаж** (эмоция, запоминается)
4. **Шпаклёвка** (для /dlya-prorabov/)

Остальные можно добить позже или заменить реальными съёмками когда Таиров пришлёт фото с объектов.
