#!/bin/zsh
# upload-wave-2.sh — заливает 36 Gemini-JPEG из локальной папки в рабочую репу
# во временную папку wave-2-raw/, чтобы Claude Code мог их прочитать и обработать.
# После деплоя папка удаляется (отдельным коммитом из cloud-сессии).
set -e

# Ищем папку с фотками — Gemini обычно сохраняет в ~/Downloads
SRC=$(find "$HOME/Downloads" "$HOME/Desktop" "$HOME/Documents" "$HOME/Загрузки" \
        -maxdepth 2 -type d \( -iname "*волна*2*" -o -iname "*wave*2*" -o -iname "*фото*сайт*" \) 2>/dev/null | head -1)
if [ -z "$SRC" ]; then
  echo "❌ Не нашёл папку с Gemini-фотками."
  echo "   Создай папку '~/Downloads/фото-волна-2/' и положи туда 36 JPEG."
  echo "   Или назови её 'wave-2' / содержащей '*волна*2*'."
  exit 1
fi
echo "    Папка с Gemini-JPEG: $SRC"

# Считаем файлы
COUNT=$(find "$SRC" -maxdepth 1 -type f -iname "*.jpeg" -o -iname "*.jpg" | wc -l | tr -d ' ')
echo "    Файлов JPEG: $COUNT"
if [ "$COUNT" = "0" ]; then
  echo "❌ Нет JPEG в $SRC"
  exit 1
fi

TMP="$HOME/.gm-wave-2-upload"
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
echo "=== 3/4 Копирую $COUNT файлов в wave-2-raw/ ==="
mkdir -p "$TMP/work/wave-2-raw"
# find вместо glob — zsh ругается nomatch если какого-то расширения нет
find "$SRC" -maxdepth 1 -type f \( -iname "*.jpeg" -o -iname "*.jpg" \) \
  -exec cp {} "$TMP/work/wave-2-raw/" \;
UPLOADED=$(ls -1 "$TMP/work/wave-2-raw/" | wc -l | tr -d ' ')
echo "    Скопировано: $UPLOADED"

echo ""
echo "=== 4/4 Коммит + пуш ==="
cd "$TMP/work"
git config user.name  "Artem Yakshin"
git config user.email "powerparadox7777@gmail.com"
git add wave-2-raw/
if git diff --cached --quiet; then
  echo "    Нет изменений — уже загружено."
else
  git commit -q -m "wave-2-raw: upload $UPLOADED Gemini photos for Claude review"
  git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q -u origin "$WORK_BRANCH"
  echo "    Запушено $UPLOADED файлов."
fi

cd "$HOME"
rm -rf "$TMP"

echo ""
echo "=== ✅ ГОТОВО ==="
echo ""
echo "  Теперь напиши Клоду в чате: «загружено, читай»"
echo "  Он прочитает каждое фото и выдаст таблицу mapping + deploy-скрипт."
