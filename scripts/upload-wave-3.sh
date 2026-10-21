#!/bin/zsh
# upload-wave-3.sh — заливает новую волну Gemini-JPEG в репу (wave-3-raw/).
# Как upload-wave-2.sh, но ищет папку "волна-3" / "wave-3".
set -e

SRC=$(find "$HOME/Downloads" "$HOME/Desktop" "$HOME/Documents" "$HOME/Загрузки" \
        -maxdepth 2 -type d \( -iname "*волна*3*" -o -iname "*wave*3*" -o -iname "*volna*3*" \) 2>/dev/null | head -1)
if [ -z "$SRC" ]; then
  echo "❌ Не нашёл папку с Gemini-фотками волны 3."
  echo "   Создай папку '~/Downloads/фото-волна-3/' и положи туда новые JPEG."
  exit 1
fi
echo "    Папка с Gemini-JPEG: $SRC"

COUNT=$(find "$SRC" -maxdepth 1 -type f \( -iname "*.jpeg" -o -iname "*.jpg" \) 2>/dev/null | wc -l | tr -d ' ')
echo "    Файлов JPEG: $COUNT"
if [ "$COUNT" = "0" ]; then
  echo "❌ Нет JPEG в $SRC"
  exit 1
fi

TMP="$HOME/.gm-wave-3-upload"
WORK_URL="https://github.com/GPTisDEAD/ciriycpro-online.git"
WORK_BRANCH="claude/vibrant-lovelace-m8u2cd"

echo ""
echo "=== 1/4 Переключаю gh на GPTisDEAD ==="
gh auth switch -u GPTisDEAD 2>/dev/null || true
git config --global --unset-all url.git@github.com:.insteadof 2>/dev/null || true

echo ""
echo "=== 2/4 Клонирую рабочую репу (shallow) ==="
rm -rf "$TMP"; mkdir -p "$TMP"
git clone -q --depth 1 -b "$WORK_BRANCH" "$WORK_URL" "$TMP/work"

echo ""
echo "=== 3/4 Копирую $COUNT файлов в wave-3-raw/ ==="
mkdir -p "$TMP/work/wave-3-raw"
find "$SRC" -maxdepth 1 -type f \( -iname "*.jpeg" -o -iname "*.jpg" \) \
  -exec cp {} "$TMP/work/wave-3-raw/" \;
UPLOADED=$(ls -1 "$TMP/work/wave-3-raw/" | wc -l | tr -d ' ')
echo "    Скопировано: $UPLOADED"

echo ""
echo "=== 4/4 Коммит + пуш ==="
cd "$TMP/work"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
git add wave-3-raw/
if git diff --cached --quiet; then
  echo "    Нет изменений — уже загружено."
else
  git commit -q -m "wave-3-raw: upload $UPLOADED Gemini photos for Claude review"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin "$WORK_BRANCH"
  echo "    Запушено $UPLOADED файлов."
fi

cd "$HOME"
rm -rf "$TMP"

echo ""
echo "=== ✅ ГОТОВО ==="
echo ""
echo "  Напиши Клоду: «волна 3 загружена, читай»"
