# pull_website_arabic.sh

سكربت صغير لسحب موقع كامل عن طريق `wget` بإعدادات مناسبة للمواقع العربية.

A small shell script for mirroring a full website with `wget`, tuned for Arabic sites.

## المشكلة | The problem

`wget` وحده مفيد، لكن الإعدادات الافتراضية تكسر أشياء كثيرة عند التعامل مع المواقع العربية والحديثة:
- روابط داخلية بأحرف عربية تفشل بلا encoding سليم.
- ملفات فرعية (`.woff2`, `.svg`, `.webp`) تسقط بدون تحويل امتدادات صحيح.
- User-Agent الافتراضي محجوب على كثير من مواقع Cloudflare.
- استخدام `--convert-links` الافتراضي يكسر الأصول لو ما ذكرت `--adjust-extension` معه.

## الحل | The solution

سكربت واحد، أمر واحد. يعيد إعدادات `wget` الموصى بها لأرشفة موقع عربي كامل قابل للفتح محلياً بدون اتصال — بضمير جيد قانونياً (يحترم `robots.txt` افتراضياً).

## الاستخدام | Usage

```bash
# 1. حمّل السكربت
curl -O https://raw.githubusercontent.com/fahad-ghazi/pull_website_arabic.sh/main/pull_website.sh
chmod +x pull_website.sh

# 2. شغّله
./pull_website.sh https://example.sa
```

الناتج ينزل تحت `./example.sa/` بروابط داخلية معدّلة تعمل locally.

## ما يفعله السكربت | What it does

- يستدعي `wget` بـ:
  - `--mirror` — يحمّل الموقع بالكامل
  - `--convert-links` — يحوّل الروابط الداخلية لتعمل locally
  - `--adjust-extension` — يضيف `.html` للصفحات المنطقية
  - `--page-requisites` — الصور والـ CSS والـ JS
  - `--no-parent` — يمنع الصعود لمسار أعلى
  - `--restrict-file-names=nocontrol` — يحافظ على الأسماء العربية
  - `-e robots=off` — اختياري، معلّق افتراضياً لاحترام `robots.txt`
  - `User-Agent` قريب من المتصفح لتجنّب حجب أساسي

## ما لا يفعله | What it does NOT do

- **لا يتخطى Cloudflare Turnstile أو Bot Fight Mode.** لو الموقع محمي حقاً، ستحتاج Playwright بدلاً منه.
- **لا يشغل JavaScript.** SPAs مبنية على React/Vue لن تُسحب صفحاتها الديناميكية.
- **لا يتحقق من الترخيص.** أنت مسؤول عن التحقق من حقّك في أرشفة الموقع.

## Requirements

- `wget` 1.20+ (تحقق بـ `wget --version`).
- macOS: `brew install wget`.
- Ubuntu/Debian: `apt install wget`.

## Roadmap

- [ ] خيار `--playwright` fallback للمواقع الديناميكية.
- [ ] تحويل تلقائي لصور WebP إلى JPG لتوافق أفضل.
- [ ] تقرير bash summary في النهاية.

## License

MIT — see [LICENSE](LICENSE).
