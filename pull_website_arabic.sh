#!/bin/bash

# 🧠 سكربت لسحب موقع كامل للعمل عليه بدون إنترنت
# ✅ مناسب للمواقع اللي ترفض التحميل (403)
# 💡 فقط غيّر الرابط في آخر السطر لأي موقع تبيه

wget \
--mirror \
--convert-links \
--adjust-extension \
--page-requisites \
--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 12_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36" \
https://example.com
