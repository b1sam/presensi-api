# Environment Variables untuk Railway

Copy semua ini ke Railway Dashboard → Variables → RAW Editor:

```env
APP_NAME=Presensi API
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:5ezJPBFzxot9ncSMMxB7eUSgz1Rtk8MiHst6ME5USvA=

# Database (pastikan nama service MySQL-nya benar!)
DB_CONNECTION=mysql
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_DATABASE=${{MySQL.MYSQLDATABASE}}
DB_USERNAME=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}

# Sessions & Cache
SESSION_DRIVER=cookie
CACHE_DRIVER=file
QUEUE_CONNECTION=sync

# Laravel
LOG_CHANNEL=stack
LOG_LEVEL=error

# Disable broadcasting
BROADCAST_DRIVER=log
```

## ⚠️ PENTING:

1. **Ganti `MySQL` dengan nama service database kamu di Railway**
   - Kalau nama database service-nya `database`, ganti jadi:
   - `${{database.MYSQLHOST}}`
   - `${{database.MYSQLPORT}}`
   - dst...

2. **Generate APP_KEY baru untuk production:**
   ```bash
   php artisan key:generate --show
   ```
   Copy hasilnya dan replace APP_KEY di atas

3. **Pastikan PORT tidak di-set manual** (Railway auto-inject $PORT)

## 🐛 Troubleshooting Jika Masih Error:

### Check Build Logs:
- Tab "Build Logs" di Railway
- Cari error message merah
- Screenshot ke saya

### Common Errors:

**"could not find driver"**
→ MySQL service belum running atau variables salah

**"Route cache failed"**
→ Sudah difix di nixpacks.toml baru

**"Connection refused"**
→ Database variables salah format

**"502 Bad Gateway"**
→ App crash saat start, cek deploy logs
