#!/bin/bash
# mega-check.sh — тотальная диагностика gruzmarket77.ru
# Запуск с Мака: curl -sSL <raw-url> | bash
set -u

DOMAIN="gruzmarket77.ru"
WWW_DOMAIN="www.gruzmarket77.ru"
RF_DOMAIN="грузмаркет77.рф"
YM_ID="113584333"
REPO="GPTisDEAD/gruzmarket77"

G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; B='\033[0;34m'; D='\033[1m'; N='\033[0m'
PASS=0; FAIL=0; WARN=0; CRIT=()

ok()   { echo -e "  ${G}✓${N} $1"; PASS=$((PASS+1)); }
fail() { echo -e "  ${R}✗${N} $1"; FAIL=$((FAIL+1)); CRIT+=("$1"); }
warn() { echo -e "  ${Y}⚠${N} $1"; WARN=$((WARN+1)); }
hdr()  { echo -e "\n${D}${B}═══ $1 ═══${N}"; }
info() { echo -e "  ${B}ℹ${N} $1"; }

# ─────────────────────────────────────────
hdr "1. DNS A-записи"
IPS=$(dig +short $DOMAIN A @8.8.8.8 2>/dev/null | sort | tr '\n' ' ')
EXPECTED="185.199.108.153 185.199.109.153 185.199.110.153 185.199.111.153 "
if [ "$IPS" = "$EXPECTED" ]; then
  ok "Все 4 IP GitHub Pages: $IPS"
else
  fail "DNS не те IP. Получили: '$IPS'. Ждали: '$EXPECTED'"
fi

WWW_CNAME=$(dig +short $WWW_DOMAIN CNAME @8.8.8.8 2>/dev/null)
if [ -n "$WWW_CNAME" ]; then
  ok "www → $WWW_CNAME"
else
  warn "www CNAME не настроен (не критично если домен работает без www)"
fi

# ─────────────────────────────────────────
hdr "2. HTTP → HTTPS редирект"
HTTP_CODE=$(curl -sS -o /dev/null -w "%{http_code}" -L --max-time 10 "http://$DOMAIN/" 2>/dev/null)
if [ "$HTTP_CODE" = "200" ]; then
  REDIR=$(curl -sS -o /dev/null -w "%{url_effective}" -L --max-time 10 "http://$DOMAIN/" 2>/dev/null)
  if [[ "$REDIR" == https://* ]]; then
    ok "http://$DOMAIN → $REDIR (301→200)"
  else
    warn "HTTP не редиректит на HTTPS: $REDIR"
  fi
else
  fail "http://$DOMAIN вернул $HTTP_CODE"
fi

# ─────────────────────────────────────────
hdr "3. HTTPS и TTFB"
HTTPS_CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/" 2>/dev/null)
TTFB=$(curl -sS -o /dev/null -w "%{time_starttransfer}" --max-time 10 "https://$DOMAIN/" 2>/dev/null)
SIZE=$(curl -sS -o /dev/null -w "%{size_download}" --max-time 10 "https://$DOMAIN/" 2>/dev/null)
if [ "$HTTPS_CODE" = "200" ]; then
  ok "HTTPS 200, TTFB=${TTFB}s, размер=${SIZE} байт"
  if (( $(echo "$TTFB > 1.0" | bc -l 2>/dev/null) )); then
    warn "TTFB > 1s — медленно, Яндекс может ругаться на скорость"
  fi
else
  fail "https://$DOMAIN вернул $HTTPS_CODE"
fi

# ─────────────────────────────────────────
hdr "4. SSL сертификат"
CERT_INFO=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -subject -issuer -dates 2>/dev/null)
if [ -n "$CERT_INFO" ]; then
  ISSUER=$(echo "$CERT_INFO" | grep issuer | sed 's/.*CN *= *//' | cut -d, -f1)
  NOT_AFTER=$(echo "$CERT_INFO" | grep notAfter | sed 's/notAfter=//')
  ok "Выдан: $ISSUER"
  ok "Действителен до: $NOT_AFTER"
else
  fail "SSL сертификат не прочитан"
fi

# ─────────────────────────────────────────
hdr "5. Загружаю главную для анализа контента"
curl -sS --max-time 15 "https://$DOMAIN/" -o /tmp/mega-index.html
HTML_SIZE=$(wc -c < /tmp/mega-index.html 2>/dev/null)
if [ "$HTML_SIZE" -gt 10000 ]; then
  ok "HTML загружен, $(( HTML_SIZE / 1024 )) KB"
else
  fail "HTML слишком маленький или пустой: $HTML_SIZE байт"
fi

# ─────────────────────────────────────────
hdr "6. Яндекс.Метрика (счётчик $YM_ID)"
if grep -q "mc.yandex.ru/metrika/tag.js" /tmp/mega-index.html; then
  ok "Скрипт metrika/tag.js в HTML"
else
  fail "НЕТ подключения metrika/tag.js"
fi

YM_COUNT=$(grep -c "$YM_ID" /tmp/mega-index.html)
if [ "$YM_COUNT" -ge 2 ]; then
  ok "ID $YM_ID встречается $YM_COUNT раз (script+noscript)"
else
  fail "ID $YM_ID в HTML всего $YM_COUNT раз (мало)"
fi

for opt in webvisor clickmap trackLinks accurateTrackBounce ecommerce; do
  if grep -q "$opt" /tmp/mega-index.html; then
    ok "Параметр $opt включён в init"
  else
    warn "Параметр $opt НЕ найден в init"
  fi
done

# пиксель Я.Метрики
PIXEL_CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://mc.yandex.ru/watch/$YM_ID" 2>/dev/null)
if [ "$PIXEL_CODE" = "200" ]; then
  ok "Пиксель mc.yandex.ru/watch/$YM_ID отвечает 200 — счётчик живой у Яндекса"
else
  warn "Пиксель mc.yandex.ru/watch/$YM_ID вернул $PIXEL_CODE"
fi

# ─────────────────────────────────────────
hdr "7. SEO: мета, viewport, canonical, OG"
grep -q "viewport" /tmp/mega-index.html && ok "mobile viewport meta" || fail "НЕТ viewport meta"
TITLE=$(grep -oP '<title>\K[^<]+' /tmp/mega-index.html | head -1)
if [ -n "$TITLE" ]; then
  TITLE_LEN=${#TITLE}
  ok "title ($TITLE_LEN симв): ${TITLE:0:70}..."
  [ "$TITLE_LEN" -gt 70 ] && warn "title длиннее 70 символов — Яндекс обрежет"
else
  fail "НЕТ title"
fi
DESC=$(grep -oP 'name="description" content="\K[^"]+' /tmp/mega-index.html | head -1)
if [ -n "$DESC" ]; then
  ok "meta description: ${DESC:0:70}..."
else
  fail "НЕТ meta description"
fi
grep -q 'rel="canonical"' /tmp/mega-index.html && ok "canonical" || fail "НЕТ canonical"
grep -q 'og:title' /tmp/mega-index.html && ok "og:title" || warn "НЕТ og:title"
grep -q 'og:image' /tmp/mega-index.html && ok "og:image" || warn "НЕТ og:image"

# ─────────────────────────────────────────
hdr "8. JSON-LD разметка"
grep -q '"@type":"LocalBusiness"' /tmp/mega-index.html && ok "LocalBusiness" || warn "НЕТ LocalBusiness"
grep -q '"@type":"FAQPage"' /tmp/mega-index.html && ok "FAQPage" || warn "НЕТ FAQPage"
grep -q '"@type":"BreadcrumbList"' /tmp/mega-index.html && ok "BreadcrumbList (главная)" || warn "НЕТ BreadcrumbList на главной (норма)"

# ─────────────────────────────────────────
hdr "9. robots.txt (критично для Яндекс.Директа)"
ROBOTS=$(curl -sS --max-time 10 "https://$DOMAIN/robots.txt")
if [ -n "$ROBOTS" ]; then
  echo "$ROBOTS" | grep -q "YandexBot" && ok "YandexBot явно разрешён" || warn "YandexBot явно НЕ упомянут (но Allow: * покрывает)"
  echo "$ROBOTS" | grep -q "GPTBot" && ok "GPTBot разрешён (LLM)" || warn "GPTBot не упомянут"
  echo "$ROBOTS" | grep -q "ClaudeBot" && ok "ClaudeBot разрешён" || warn "ClaudeBot не упомянут"
  echo "$ROBOTS" | grep -qE "Disallow:\s*/\s*$" && fail "ОПАСНО: Disallow: / блокирует всё!"
  echo "$ROBOTS" | grep -q "Sitemap:" && ok "ссылка на sitemap" || warn "НЕТ ссылки на Sitemap в robots.txt"
else
  fail "robots.txt не прочитан"
fi

# ─────────────────────────────────────────
hdr "10. sitemap.xml и llms.txt"
for path in "sitemap-index.xml" "sitemap-0.xml" "llms.txt" "llms-full.txt"; do
  CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/$path")
  if [ "$CODE" = "200" ]; then
    ok "/$path → 200"
  else
    warn "/$path → $CODE"
  fi
done

# ─────────────────────────────────────────
hdr "11. OG-картинка и favicon"
OG_CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/og-default.jpg")
[ "$OG_CODE" = "200" ] && ok "/og-default.jpg → 200" || fail "/og-default.jpg → $OG_CODE"
FAV_CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/favicon.svg")
[ "$FAV_CODE" = "200" ] && ok "/favicon.svg → 200" || warn "/favicon.svg → $FAV_CODE"

# ─────────────────────────────────────────
hdr "12. Ключевые страницы отдают 200"
for page in "" "uslugi/" "uslugi/demontazh/" "uslugi/gruzchiki/" "kejsy/" "kejsy/demontazh-kvartiry-78/" "tseny/" "kontakty/" "zayavka/" "vopros-otvet/" "dlya-prorabov/"; do
  CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "https://$DOMAIN/$page")
  [ "$CODE" = "200" ] && ok "/$page → 200" || fail "/$page → $CODE"
done

# ─────────────────────────────────────────
hdr "13. Контакты в HTML (телефон, WhatsApp, email)"
grep -q "+7 926 614-39-59\|tel:+79266143959" /tmp/mega-index.html && ok "телефон Таирова" || fail "НЕТ телефона в HTML"
grep -q "wa.me/79266143959" /tmp/mega-index.html && ok "WhatsApp" || fail "НЕТ WhatsApp"
grep -q "tgk-777@mail.ru" /tmp/mega-index.html && ok "email" || warn "email не в HTML (возможно только в footer)"
grep -q "050401330914" /tmp/mega-index.html && ok "ИНН в HTML (E-E-A-T сигнал)" || warn "ИНН не в HTML"

# ─────────────────────────────────────────
hdr "14. GitHub Actions + Pages (под твоим gh)"
RUN=$(gh run list -R $REPO --limit 1 --json status,conclusion,name 2>/dev/null | head -c 300)
if [[ "$RUN" == *success* ]]; then
  ok "Последний деплой: completed success"
elif [[ "$RUN" == *in_progress* ]]; then
  warn "Деплой ещё бежит"
elif [[ "$RUN" == *failure* ]]; then
  fail "Последний деплой УПАЛ: $RUN"
else
  warn "Статус деплоя не разобран: $RUN"
fi

PAGES=$(gh api "repos/$REPO/pages" 2>/dev/null)
if [ -n "$PAGES" ]; then
  CNAME_PAGES=$(echo "$PAGES" | grep -o '"cname":"[^"]*"' | cut -d'"' -f4)
  CERT_STATE=$(echo "$PAGES" | grep -o '"state":"[^"]*"' | head -1 | cut -d'"' -f4)
  HTTPS_ENF=$(echo "$PAGES" | grep -o '"https_enforced":[a-z]*' | cut -d: -f2)
  [ "$CNAME_PAGES" = "$DOMAIN" ] && ok "Pages custom domain = $CNAME_PAGES" || warn "Pages cname: '$CNAME_PAGES'"
  [ "$CERT_STATE" = "approved" ] && ok "Pages HTTPS cert state: approved" || warn "cert state: $CERT_STATE"
  [ "$HTTPS_ENF" = "true" ] && ok "HTTPS enforced" || warn "HTTPS enforced = $HTTPS_ENF (можно включить)"
fi

# ─────────────────────────────────────────
hdr "ИТОГО"
TOTAL=$((PASS+FAIL+WARN))
echo ""
echo -e "  ${G}✓ PASS${N}: $PASS"
echo -e "  ${Y}⚠ WARN${N}: $WARN"
echo -e "  ${R}✗ FAIL${N}: $FAIL"
echo -e "  Всего проверок: $TOTAL"
echo ""

if [ "$FAIL" -eq 0 ]; then
  echo -e "${G}${D}╔════════════════════════════════════════╗${N}"
  echo -e "${G}${D}║  САЙТ ТЕХНИЧЕСКИ ПОЛНОСТЬЮ ГОТОВ      ║${N}"
  echo -e "${G}${D}║  к рекламе Я.Директа и индексации     ║${N}"
  echo -e "${G}${D}╚════════════════════════════════════════╝${N}"
  echo ""
  echo "Яндекс.Директ ругается скорее всего из-за одного из двух:"
  echo "  1) Нет статистики (счётчик свежий, снимется через 7-14 дней)"
  echo "  2) Счётчик привязан к другому Яндекс.Паспорту чем Директ"
  echo ""
  echo "Проверь: Я.Метрика → Настройка счётчика $YM_ID → Доступ"
  echo "В списке должен быть email под которым открыт твой Директ."
else
  echo -e "${R}${D}КРИТИЧЕСКИЕ ПРОБЛЕМЫ:${N}"
  for c in "${CRIT[@]}"; do echo -e "  ${R}•${N} $c"; done
fi
