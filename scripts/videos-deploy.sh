#!/bin/zsh
# videos-deploy.sh — заливка Veo-клипов в прод.
# Исходники: ~/Downloads/видосы для сайта/ (или ~/Загрузки/...)
# Файлы называются по именам из ADR-GruzMarket-26/video-prompts/:
#   01-hero.mp4
#   02-demontazh.mp4
#   03-klining.mp4
#   04-pogruzka-musora.mp4   (опционально, пока в прод не идёт)
#   05-shpaklevka.mp4
#   06-moyka-okon.mp4
#   07-stend.mp4             (опционально)
#   08-plitka.mp4
#   09-elektrika.mp4         (опционально)
#   10-styazhka.mp4          (опционально)
#   11-sneg.mp4              (опционально)
#
# Из них 6 обязательных для прод-эффекта идут в:
#   site/public/video/hero.mp4                  ← 01
#   site/public/video/uslugi/demontazh.mp4      ← 02
#   site/public/video/uslugi/uborka-posle-remonta.mp4   ← 03
#   site/public/video/uslugi/otdelochnye-raboty.mp4     ← 05
#   site/public/video/uslugi/mytyo-okon.mp4             ← 06
#   site/public/video/uslugi/otdelka-pod-klyuch.mp4     ← 08
#
# Для каждого MP4 скрипт ещё делает poster-картинку (первый кадр) через ffmpeg.
set -e

SRC=$(find "$HOME/Downloads" "$HOME/Desktop" "$HOME/Documents" "$HOME/Загрузки" \
        -maxdepth 2 -type d -iname "*видос*" 2>/dev/null | head -1)
if [ -z "$SRC" ]; then
  SRC=$(find "$HOME/Downloads" "$HOME/Desktop" "$HOME/Documents" "$HOME/Загрузки" \
          -maxdepth 2 -type d -iname "*video*сайт*" 2>/dev/null | head -1)
fi
if [ -z "$SRC" ]; then
  echo "❌ Не нашёл папку с видосами."
  echo "   Создай папку '~/Downloads/видосы для сайта/' и положи туда MP4."
  exit 1
fi
echo "    Папка видосов: $SRC"

TMP="$HOME/.gm-videos-work"
WORK_URL="https://github.com/GPTisDEAD/ciriycpro-online.git"
WORK_BRANCH="claude/vibrant-lovelace-m8u2cd"
PROD_URL="https://github.com/GPTisDEAD/gruzmarket77.git"

echo ""
echo "=== 0/6 Проверка tool-chain ==="
if ! command -v ffmpeg &>/dev/null; then
  echo "    Ставлю ffmpeg через brew (нужен для poster-кадров и для лёгкого ресайза)..."
  brew install ffmpeg
fi

# Карта: source-pattern → prod-path (без расширений)
typeset -A VIDEO_MAP
VIDEO_MAP=(
  "01*"       "video/hero"
  "02*"       "video/uslugi/demontazh"
  "03*"       "video/uslugi/uborka-posle-remonta"
  "05*"       "video/uslugi/otdelochnye-raboty"
  "06*"       "video/uslugi/mytyo-okon"
  "08*"       "video/uslugi/otdelka-pod-klyuch"
)

echo ""
echo "=== 1/6 Проверка наличия ключевых клипов ==="
FOUND=0
MISSING=""
for pat in ${(k)VIDEO_MAP}; do
  F=$(find "$SRC" -maxdepth 1 -type f -iname "${pat}.mp4" 2>/dev/null | head -1)
  if [ -z "$F" ]; then
    MISSING="$MISSING  — ${pat}.mp4 → ${VIDEO_MAP[$pat]}.mp4\n"
  else
    FOUND=$((FOUND + 1))
    echo "    ✓ $(basename "$F") → ${VIDEO_MAP[$pat]}.mp4"
  fi
done
if [ "$FOUND" = "0" ]; then
  echo "❌ Нет ни одного MP4 в $SRC"
  echo "   Переименуй файлы в начало с 01, 02, 03, 05, 06, 08 (как в video-prompts/)"
  exit 1
fi
if [ -n "$MISSING" ]; then
  echo ""
  echo "    ⚠️ Пропущены (поедут при следующем прогоне):"
  echo -e "$MISSING"
fi

echo ""
echo "=== 2/6 Переключаю gh на GPTisDEAD ==="
gh auth switch -u GPTisDEAD 2>/dev/null || true
git config --global --unset-all url.git@github.com:.insteadof 2>/dev/null || true

echo ""
echo "=== 3/6 Клонирую рабочую репу ==="
rm -rf "$TMP"; mkdir -p "$TMP"
git clone -q --depth 1 -b "$WORK_BRANCH" "$WORK_URL" "$TMP/work"
mkdir -p "$TMP/work/site/public/video/uslugi"
mkdir -p "$TMP/work/site/public/img"

echo ""
echo "=== 4/6 Копирую MP4 + генерирую poster-кадры (первый кадр, Q80 JPEG) ==="
for pat in ${(k)VIDEO_MAP}; do
  F=$(find "$SRC" -maxdepth 1 -type f -iname "${pat}.mp4" 2>/dev/null | head -1)
  [ -z "$F" ] && continue
  DEST="$TMP/work/site/public/${VIDEO_MAP[$pat]}.mp4"
  POSTER="$TMP/work/site/public/${VIDEO_MAP[$pat]}-poster.jpg"
  # для hero poster идёт в /img/hero-poster.jpg (не перезаписываем hero.webp)
  if [ "${VIDEO_MAP[$pat]}" = "video/hero" ]; then
    POSTER="$TMP/work/site/public/img/hero-video-poster.jpg"
  fi

  # Ресайз MP4 до 1280 wide, перекодировка h264 Q27 (сжатие ~в 3-5 раз без потери восприятия)
  echo "  $(basename "$F") → ${VIDEO_MAP[$pat]}.mp4 (ресайз 1280w h264)"
  ffmpeg -y -hide_banner -loglevel error -i "$F" \
    -vf "scale=1280:-2" -c:v libx264 -preset slow -crf 27 \
    -movflags +faststart -an "$DEST"

  # Poster: первый кадр через 0.5 сек в JPEG
  echo "  → poster: $(basename "$POSTER")"
  ffmpeg -y -hide_banner -loglevel error -i "$F" \
    -vf "scale=1280:-2" -ss 00:00:00.5 -vframes 1 -q:v 3 "$POSTER"
done

echo ""
echo "    Итого размеры:"
du -h "$TMP/work/site/public/video"/*.mp4 "$TMP/work/site/public/video/uslugi"/*.mp4 2>/dev/null | sed 's/^/      /'

echo ""
echo "=== 5/6 Коммит + пуш в рабочую, затем sync в прод ==="
cd "$TMP/work"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
git add site/public/video/ site/public/img/
if git diff --cached --quiet; then
  echo "    Нет изменений в рабочей — пропускаю пуш."
else
  git commit -q -m "video: deploy $FOUND clip(s) with posters"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin "$WORK_BRANCH"
  echo "    Запушено в рабочую."
fi

git clone -q "$PROD_URL" "$TMP/prod"
cd "$TMP/prod"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
rsync -a --delete --exclude='.git' "$TMP/work/site/" "$TMP/prod/"
git add -A
if git diff --cached --quiet; then
  echo "    Нет изменений в проде — пропускаю пуш."
else
  git commit -q -m "sync: deploy $FOUND Veo clip(s)"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin main
  echo "    Запушено в прод."
fi

cd "$HOME"
rm -rf "$TMP"

echo ""
echo "=== 6/6 ✅ ГОТОВО ==="
echo ""
echo "  Деплой пойдёт 1-3 минуты. Проверь:"
echo "    https://gruzmarket77.ru/   (hero с видео)"
echo "    https://gruzmarket77.ru/uslugi/demontazh/"
echo "    https://gruzmarket77.ru/uslugi/uborka-posle-remonta/"
echo "    https://gruzmarket77.ru/uslugi/otdelochnye-raboty/"
echo "    https://gruzmarket77.ru/uslugi/mytyo-okon/"
echo "    https://gruzmarket77.ru/uslugi/otdelka-pod-klyuch/"
