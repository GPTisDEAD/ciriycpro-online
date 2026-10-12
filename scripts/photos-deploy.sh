#!/bin/zsh
# photos-deploy.sh — конверт 12 JPEG от Gemini в 16 WebP, пуш в рабочую и прод-репу.
# Исходники: ~/Загрузки/фотки для сайта/
# Выход: /img/hero.webp + /img/cases/{slug}-{before,after,card}.webp (×5 кейсов)
set -e

# Ищем папку "фотки для сайта" в Downloads/Desktop/Documents через find
# (macOS хранит кириллицу в разных формах Unicode — литерал в скрипте не всегда равен имени на диске).
SRC=$(find "$HOME/Downloads" "$HOME/Desktop" "$HOME/Documents" "$HOME/Загрузки" \
        -maxdepth 2 -type d -iname "*фот*для*сайта" 2>/dev/null | head -1)
if [ -z "$SRC" ]; then
  SRC="$HOME/Downloads/фотки для сайта"  # для сообщения об ошибке
fi
TMP="$HOME/.gm-photos-work"
WORK_URL="https://github.com/GPTisDEAD/ciriycpro-online.git"
WORK_BRANCH="claude/vibrant-lovelace-m8u2cd"
PROD_URL="https://github.com/GPTisDEAD/gruzmarket77.git"

echo "=== 0/7 Проверка окружения ==="
if ! command -v cwebp &>/dev/null; then
  echo "    Ставлю webp через brew..."
  brew install webp
fi
if [ ! -d "$SRC" ]; then
  echo "    ❌ Нет папки '$SRC'"
  exit 1
fi

echo ""
echo "=== 1/7 Проверка 2 новых файлов (sanuzel-before + helpery-after) ==="
MISSING=0
for f in "sanuzel-before.jpeg" "helpery-after.jpeg"; do
  if [ ! -f "$SRC/$f" ]; then
    echo "    ❌ Нет '$SRC/$f'"
    MISSING=1
  else
    echo "    ✓ $f"
  fi
done
if [ "$MISSING" = "1" ]; then
  echo ""
  echo "Переименуй в Finder'е 2 только что сгенерированных фото:"
  echo "   — санузел с голыми кирпичами и каской  →  sanuzel-before.jpeg"
  echo "   — готовый выставочный зал              →  helpery-after.jpeg"
  echo "Положи их в: $SRC"
  echo "И запусти этот скрипт заново."
  exit 1
fi

echo ""
echo "=== 2/7 Переключаю gh на GPTisDEAD ==="
gh auth switch -u GPTisDEAD 2>/dev/null || true
git config --global --unset-all url.git@github.com:.insteadof 2>/dev/null || true

echo ""
echo "=== 3/7 Клонирую рабочую репу ==="
rm -rf "$TMP"; mkdir -p "$TMP"
git clone -q --depth 1 -b "$WORK_BRANCH" "$WORK_URL" "$TMP/work"
mkdir -p "$TMP/work/site/public/img/cases"
IMG="$TMP/work/site/public/img"

echo ""
echo "=== 4/7 Конверт 12 JPEG → 16 WebP (hero + 5 кейсов × 3) ==="

# hero
echo "  hero.webp"
cwebp -quiet -q 85 -resize 1920 0 \
  "$SRC/1 Gemini_Generated_Image_6ypvsn6ypvsn6ypv.jpeg" \
  -o "$IMG/hero.webp"

# demontazh-kvartiry-78
echo "  demontazh-kvartiry-78: before + after + card"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/2 Gemini_Generated_Image_4nr3yr4nr3yr4nr3.jpeg" \
  -o "$IMG/cases/demontazh-kvartiry-78-before.webp"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/3 Gemini_Generated_Image_kkxqiukkxqiukkxq.jpeg" \
  -o "$IMG/cases/demontazh-kvartiry-78-after.webp"
cwebp -quiet -q 80 -resize 1280 0 \
  "$SRC/3 Gemini_Generated_Image_kkxqiukkxqiukkxq.jpeg" \
  -o "$IMG/cases/demontazh-kvartiry-78-card.webp"

# uborka-ofisa-240
echo "  uborka-ofisa-240: before + after + card"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/4 Gemini_Generated_Image_7gtrbz7gtrbz7gtr.jpeg" \
  -o "$IMG/cases/uborka-ofisa-240-before.webp"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/5 Gemini_Generated_Image_6j7e9d6j7e9d6j7e.jpeg" \
  -o "$IMG/cases/uborka-ofisa-240-after.webp"
cwebp -quiet -q 80 -resize 1280 0 \
  "$SRC/5 Gemini_Generated_Image_6j7e9d6j7e9d6j7e.jpeg" \
  -o "$IMG/cases/uborka-ofisa-240-card.webp"

# sanuzel-kuhnya
echo "  sanuzel-kuhnya: before + after + card"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/sanuzel-before.jpeg" \
  -o "$IMG/cases/sanuzel-kuhnya-before.webp"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/6 Gemini_Generated_Image_6tt6yj6tt6yj6tt6.jpeg" \
  -o "$IMG/cases/sanuzel-kuhnya-after.webp"
cwebp -quiet -q 80 -resize 1280 0 \
  "$SRC/9 Gemini_Generated_Image_1626uo1626uo1626 (1).jpeg" \
  -o "$IMG/cases/sanuzel-kuhnya-card.webp"

# helpery-vystavka
echo "  helpery-vystavka: before + after + card"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/7 Gemini_Generated_Image_p6259kp6259kp625.jpeg" \
  -o "$IMG/cases/helpery-vystavka-before.webp"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/helpery-after.jpeg" \
  -o "$IMG/cases/helpery-vystavka-after.webp"
cwebp -quiet -q 80 -resize 1280 0 \
  "$SRC/helpery-after.jpeg" \
  -o "$IMG/cases/helpery-vystavka-card.webp"

# abonent-klining-120
echo "  abonent-klining-120: before + after + card"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/8 1 Gemini_Generated_Image_1626uo1626uo1626.jpeg" \
  -o "$IMG/cases/abonent-klining-120-before.webp"
cwebp -quiet -q 82 -resize 1800 0 \
  "$SRC/8 Gemini_Generated_Image_30xmvo30xmvo30xm.jpeg" \
  -o "$IMG/cases/abonent-klining-120-after.webp"
cwebp -quiet -q 80 -resize 1280 0 \
  "$SRC/8 Gemini_Generated_Image_30xmvo30xmvo30xm.jpeg" \
  -o "$IMG/cases/abonent-klining-120-card.webp"

echo ""
echo "    Итого WebP:"
du -h "$IMG"/*.webp "$IMG"/cases/*.webp | sort -k2 | sed 's/^/      /'

echo ""
echo "=== 5/7 Коммит + пуш в рабочую репу ==="
cd "$TMP/work"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
git add site/public/img/
if git diff --cached --quiet; then
  echo "    Нет изменений в рабочей — пропускаю пуш."
else
  git commit -q -m "images: add 16 WebP photos (hero + 5 cases × 3 variants)"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin "$WORK_BRANCH"
  echo "    Запушено в рабочую."
fi

echo ""
echo "=== 6/7 Sync в прод-репу ==="
git clone -q "$PROD_URL" "$TMP/prod"
cd "$TMP/prod"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
rsync -a --delete --exclude='.git' "$TMP/work/site/" "$TMP/prod/"
git add -A
if git diff --cached --quiet; then
  echo "    Нет изменений в проде — пропускаю пуш."
else
  SUMMARY=$(cd "$TMP/work" && git log -1 --pretty=%s)
  git commit -q -m "sync: $SUMMARY"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin main
  echo "    Запушено в прод."
fi

cd "$HOME"
rm -rf "$TMP"

echo ""
echo "=== 7/7 ✅ ГОТОВО ==="
echo ""
echo "  Боевой сайт пересобирается — зайди через 2 минуты:"
echo "    https://gruzmarket77.ru/"
echo ""
echo "  Прогресс деплоя:"
echo "    https://github.com/GPTisDEAD/gruzmarket77/actions"
