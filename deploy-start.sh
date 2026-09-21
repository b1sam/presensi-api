#!/bin/sh
# Start script untuk Railway.
# Migrate di-retry karena service MySQL di Railway bisa jalan belakangan
# daripada web service. Kalau migrate tetap gagal, server tetap dinyalakan
# supaya error aslinya terbaca di Deploy Logs dan /api/health tetap hidup.

php artisan config:cache

attempt=1
migrated=0
while [ $attempt -le 3 ]; do
    if php artisan migrate --force; then
        migrated=1
        break
    fi
    echo "[start] migrate gagal (percobaan $attempt/3), retry 3 detik lagi..."
    attempt=$((attempt + 1))
    sleep 3
done

if [ "$migrated" -eq 0 ]; then
    echo "[start] === MIGRATE GAGAL - CEK PESAN ERROR DI ATAS / SETTING DATABASE ==="
fi

exec php artisan serve --host=0.0.0.0 --port="${PORT:-8080}"
