# AI-промпты для 11 изображений — GruzMarket77

> Для генерации в **Gemini / Imagen 3**. На английском — модели пишут лучше.
> Все промпты уже содержат палитру дизайн-кода, стиль и негатив.
> Копируй промпт целиком, вставляй в Gemini → генерируй → качай → переименовывай по таблице → в репу.

---

## Общие правила (вшиты в каждый промпт)

- **Стиль**: documentary industrial photography, 35mm, natural lighting
- **Палитра кадра**: graphite tones (#1C252B / #3A4047 / #4B5053) + warm orange accent (#F47B20) только одним предметом (каска, перчатка, инструмент, расходник)
- **Без лиц**: только силуэты, спины, руки в перчатках, или вообще без людей
- **Соотношение**: 16:9 (hero/карточки) или 3:2 (до/после)
- **Негатив во всех**: `no faces, no visible logos, no text, no watermark, no cartoon, no 3d render, no stock photo smile`

---

## Таблица слотов (куда класть что)

| № | Файл в репе | Назначение | Размер | Промпт |
|---|---|---|---|---|
| 1 | `site/public/img/hero.webp` | Hero главной (опционально) | 1600×1000 | §1 |
| 2 | `site/public/img/cases/demontazh-kvartiry-78-card.webp` | Карточка кейса №1 | 1280×720 | §2.1 (afterот) |
| 3 | `site/public/img/cases/demontazh-kvartiry-78-before.webp` | До | 1800×1200 | §2.1-before |
| 4 | `site/public/img/cases/demontazh-kvartiry-78-after.webp` | После | 1800×1200 | §2.1-after |
| 5 | `site/public/img/cases/uborka-ofisa-240-card.webp` | Карточка кейса №2 | 1280×720 | §2.2 (afterот) |
| 6 | `site/public/img/cases/uborka-ofisa-240-before.webp` | До | 1800×1200 | §2.2-before |
| 7 | `site/public/img/cases/uborka-ofisa-240-after.webp` | После | 1800×1200 | §2.2-after |
| 8 | `site/public/img/cases/helpery-vystavka-card.webp` | Карточка кейса №3 | 1280×720 | §2.3 |
| 9 | `site/public/img/cases/sanuzel-kuhnya-card.webp` | Карточка кейса №4 | 1280×720 | §2.4 (afterот) |
| 10 | `site/public/img/cases/sanuzel-kuhnya-after.webp` | После | 1800×1200 | §2.4-after |
| 11 | `site/public/img/cases/abonent-klining-120-card.webp` | Карточка кейса №5 | 1280×720 | §2.5 |

---

## § 1. Hero главной

```
Wide documentary photograph of a Moscow construction site interior.
A single worker from behind wearing an orange safety helmet and orange
work vest, carrying a bundle of long tools over the shoulder, walking
away from camera toward a tall window with soft morning light. Bare
concrete walls, scattered construction materials neatly stacked, dust
visible in the beam of light. Graphite and warm orange color grading.
Shallow depth of field, 35mm, realistic, cinematic but not glossy.

16:9 aspect ratio.

Negative: no face, no visible logos, no text, no watermark, no cartoon,
no 3d render, no stock photo smile, no multiple people.
```

---

## § 2. Кейсы

### 2.1. Демонтаж квартиры 78 м² (кейс №1 из corpus §8.1)

**«ДО» — старая квартира перед сносом:**
```
Documentary photograph, interior of an old Soviet-era Moscow apartment
before major renovation. Peeling floral wallpaper, cracked gray plaster
walls, worn-out parquet floor with gaps, dusty window with afternoon
light, old-fashioned radiator under the window, bare lightbulb hanging
from the ceiling. Empty rooms, no furniture, no people. Faded brown
and beige tones, slight haze in the air. 35mm realistic photography.

3:2 aspect ratio.

Negative: no faces, no logos, no text, no watermark, no cartoon.
```

**«ПОСЛЕ» — после демонтажа «до бетона»:**
```
Documentary photograph, same Moscow apartment after full demolition
to concrete shell. Bare raw concrete walls with freshly removed plaster
marks, clean concrete floor without screed, dust still settling, three
heavy-duty orange construction debris bags neatly stacked in the corner,
one orange safety helmet placed on top of a bag as a focal accent.
Bright window light from an uncurtained window. Cool graphite tones,
single warm orange accent. 35mm realistic.

3:2 aspect ratio.

Negative: no faces, no people, no logos, no text, no watermark,
no cartoon.
```

---

### 2.2. Уборка после ремонта офиса 240 м² (кейс №2 из corpus §8.2)

**«ДО» — офис после ремонта, до клининга:**
```
Documentary photograph of a large open-space office in Moscow just after
construction finished, before cleaning. Grey construction dust covers
the laminate floor, white protective film still on floor-to-ceiling
windows, scattered empty paint buckets and cardboard packaging boxes,
plaster bags leaned against a wall, bright industrial-looking LED
ceiling lights on. No people. Cold daylight through filmed windows,
dusty haze. Realistic documentary photo, 35mm.

3:2 aspect ratio.

Negative: no faces, no people, no logos, no text, no watermark,
no cartoon.
```

**«ПОСЛЕ» — тот же офис после профессиональной уборки:**
```
Documentary photograph of the same open-space Moscow office after
professional post-renovation cleaning. Spotless glossy laminate floor
reflecting ceiling lights, perfectly clean floor-to-ceiling windows
with crisp daylight, protective film completely removed, one orange
professional cleaning caddy with spray bottles and microfiber cloths
placed in the foreground as a focal accent. Empty, clean, bright.
Graphite tones, single warm orange accent. 35mm realistic.

3:2 aspect ratio.

Negative: no faces, no people, no logos, no text, no watermark,
no cartoon.
```

---

### 2.3. Хелперы на выставку (кейс №3 из corpus §8.3)

**Карточка/монтаж стендов:**
```
Documentary wide shot of an exhibition hall at a Moscow convention
center during setup phase. Rows of partially assembled metal
exhibition stand frames, stacked white display panels leaning against
each other, several empty cargo trolleys with orange handles, scattered
power cables on the floor, bright industrial overhead lighting with
visible light beams through faint dust. Two or three worker silhouettes
far in the background, blurred, from behind, wearing orange high-vis
vests. Graphite industrial atmosphere with warm orange accents.
35mm realistic documentary.

16:9 aspect ratio.

Negative: no visible faces, no close-up people, no logos, no text,
no watermark, no cartoon.
```

---

### 2.4. Санузел и кухня под ключ (кейс №4 из corpus §8.4)

**«ПОСЛЕ» — готовая ванная + карточка:**
```
Documentary photograph of a newly renovated compact bathroom in a Moscow
apartment, interior shot. Fresh large-format matte gray porcelain tiles
on floor and walls, white rectangular bathtub with chrome fixtures,
built-in drywall niche with ambient light strip inside, floating vanity
with a round mirror, warm spot lighting from above. Clean, modern,
precise construction work visible. One rolled orange microfiber cloth
hanging on a chrome rail as a tiny warm accent. No people. 35mm realistic
photography, soft natural palette with graphite tones.

3:2 aspect ratio.

Negative: no faces, no people, no logos, no text, no watermark,
no cartoon, no obvious 3d render.
```

---

### 2.5. Абонентский клининг офиса 120 м² (кейс №5 из corpus §8.5)

**Карточка — чистый офис вечером:**
```
Documentary photograph of a small modern Moscow office interior in the
evening, 25 employee desks arranged in rows, all desks perfectly clean
and empty — monitors off, chairs tucked in, no clutter. Soft warm
evening lighting through large windows, polished floor reflecting light,
one small orange cleaning spray bottle and folded microfiber cloth left
on a desk as a focal accent. Deep graphite tones, single warm orange
highlight. Clean, calm, after-work atmosphere. 35mm realistic.

16:9 aspect ratio.

Negative: no faces, no people, no logos on screens or walls, no text,
no watermark, no cartoon.
```

---

## Карточки «card»

Если лень генерировать отдельно — для карточек используй **«after»-варианты** и кропни их в 1280×720 (можно прямо в Gemini попросить кроп). Для кейса №3 (выставка) и №5 (абонентка) есть по одному промпту — он сразу под карточку (16:9).

---

## После генерации

1. Переименуй файлы ровно по таблице выше.
2. Скинь мне в чат «фото залиты в site/public/img/cases/» (или просто кидай архив).
3. Я одним коммитом:
   - Вставлю `<img>` вместо CSS-градиентов в `CaseCard.astro` и `src/pages/kejsy/[slug].astro`
   - Добавлю `loading="lazy"`, явные width/height, `alt` из `title` кейса
   - Hero опционально — вставлю, если дашь.
4. Деплой автоматом → сайт с живыми фото.

---

## Если фото не нравятся — промпт-правки на лету

- **«Слишком стоково, нужно грубее»** → добавь `grainy, imperfect, slight motion blur, documentary edge`
- **«Оранжевого слишком много»** → `single tiny orange accent only, otherwise strictly graphite palette`
- **«Хочу зимнюю Москву»** → `winter afternoon light, bare trees seen through window`
- **«Нужны руки, не силуэты»** → замени «no people» на `only hands wearing orange work gloves holding a tool, from above POV`

---

Всё, фото часть завязана. Реальные фото Таирова (когда появятся) кладутся в те же имена файлов — сайт подхватит без правок кода.
