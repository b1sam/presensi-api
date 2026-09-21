# Environment Variables untuk Railway

Copy semua ini ke Railway Dashboard → service API → Variables → RAW Editor:

```env
APP_NAME=Presensi API
APP_ENV=production
APP_DEBUG=false
APP_KEY=<GENERATE_DULU - lihat bawah>

DB_CONNECTION=mysql
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_DATABASE=${{MySQL.MYSQLDATABASE}}
DB_USERNAME=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}

SESSION_DRIVER=cookie
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
LOG_CHANNEL=stack
LOG_LEVEL=error
BROADCAST_DRIVER=log
```

## 🔑 Generate APP_KEY (JANGAN PAKAI KEY DARI COMMIT LAMA - SUDAH BOCOR)

Key lama yang pernah di-commit ke repo ini jangan dipakai lagi. Generate yang baru:

- Double-click `generate-key.bat` di folder project, ATAU
- Jalankan: `php artisan key:generate --show`

Copy hasilnya, replace `<GENERATE_DULU - lihat bawah>` di atas.

## ⚠️ PENTING: Nama service MySQL

`${{MySQL.MYSQLHOST}}` — kata `MySQL` harus **sama persis** (case-sensitive) dengan
nama service database di canvas Railway.

- Cek: klik card MySQL di canvas, lihat nama di atas card
- Kalau nama service-nya `mysql` atau `MySQL-2`, ganti semua referensinya

**Cara anti-gagal:** klik card MySQL → tab Variables → copy nilai
`MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER`, `MYSQLPASSWORD`
satu-satu, paste langsung sebagai nilai tanpa tanda `${{...}}`.

## ✅ Verifikasi setelah redeploy

1. Tunggu deployment "Success"
2. Buka `https://<domain-api>/api/health`
   → harusnya `{"status":"ok","message":"Presensi API is running",...}`
3. Test `POST /api/register` dan `POST /api/login` dari Postman

Tabel database terbentuk otomatis: start script (`deploy-start.sh`) menjalankan
`php artisan migrate --force` setiap service start. Tidak perlu buat tabel manual.

## 🐛 Troubleshooting

**Cek tab "Deploy Logs" di Railway** — dengan start script yang baru, server
tetap hidup walau migrate gagal, jadi error aslinya selalu terlihat di log.

| Pesan error | Penyebab |
|---|---|
| `could not find driver` | Ekstensi pdo_mysql (sudah ada di Dockerfile, berarti bukan ini) |
| `Connection refused` / `php_network_getaddresses` | MySQL belum running, atau DB_HOST salah |
| `Access denied for user` | DB_USERNAME / DB_PASSWORD salah |
| `Unknown database` | DB_DATABASE salah (default Railway: `railway`) |
| `SQLSTATE[HY000] [2002]` | Referensi `${{...}}` tidak resolve — cek nama service |
| API 500 saat login/register, health 200 | APP_KEY kosong, atau tabel belum ter-migrate (cek Deploy Logs) |
