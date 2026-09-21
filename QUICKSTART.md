# 🚀 Quick Start - Deploy ke Railway

Panduan cepat deploy API Presensi ke Railway (5-10 menit).

## 📋 Yang Kamu Butuhkan

- ✅ Akun GitHub (gratis)
- ✅ Akun Railway (gratis, $5 credit/bulan)
- ✅ Git terinstall di komputer

---

## 🎯 Langkah Deploy (Simple)

### 1️⃣ Push ke GitHub

```bash
# Di folder project
cd c:\xampp\htdocs\presensibk\presensi-backend-master

# Initialize git
git init
git add .
git commit -m "Initial commit - Presensi API"

# Buat repo BARU di GitHub: https://github.com/new
# Nama: presensi-backend (atau terserah)

# Connect & push
git branch -M main
git remote add origin https://github.com/USERNAME/presensi-backend.git
git push -u origin main
```

Ganti `USERNAME` dengan username GitHub kamu.

---

### 2️⃣ Deploy di Railway

1. **Buka Railway**
   - Go to: https://railway.app
   - Klik "Login with GitHub"
   - Authorize Railway

2. **Create New Project**
   - Klik "New Project"
   - Pilih "Deploy from GitHub repo"
   - Cari & pilih `presensi-backend`
   - Railway mulai deploy otomatis ✅

3. **Add MySQL Database**
   - Di dashboard project, klik tombol "New"
   - Pilih "Database" → "Add MySQL"
   - Tunggu MySQL jalan (ikon hijau)

4. **Set Environment Variables**
   
   Klik service API kamu → tab "Variables" → "RAW Editor"
   
   Paste ini:
   ```env
   APP_NAME=Presensi API
   APP_ENV=production
   APP_DEBUG=false
   APP_KEY=base64:5ezJPBFzxot9ncSMMxB7eUSgz1Rtk8MiHst6ME5USvA=
   
   DB_CONNECTION=mysql
   DB_HOST=${{MySQL.MYSQLHOST}}
   DB_PORT=${{MySQL.MYSQLPORT}}
   DB_DATABASE=${{MySQL.MYSQLDATABASE}}
   DB_USERNAME=${{MySQL.MYSQLUSER}}
   DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}
   
   SESSION_DRIVER=cookie
   CACHE_DRIVER=file
   ```
   
   **PENTING:** Ganti `MySQL` dengan nama service MySQL kamu (biasanya `MySQL` atau `database`)

5. **Generate Public URL**
   - Masih di service API → tab "Settings"
   - Scroll ke bagian "Networking"
   - Klik "Generate Domain"
   - Copy URL-nya: `https://presensi-backend-production-XXXX.up.railway.app`

6. **Redeploy**
   - Tab "Deployments" → klik 3 dots → "Redeploy"
   - Atau push commit baru ke GitHub (auto-deploy)

---

### 3️⃣ Test API

```bash
# Health check
curl https://your-railway-app.up.railway.app/api/health

# Should return:
# {"status":"ok","message":"Presensi API is running","timestamp":"..."}
```

---

## ✅ Done! API Kamu Sudah Live

**URL API:** `https://your-app.up.railway.app`

### Endpoints:
- `POST /api/register` - Daftar user baru
- `POST /api/login` - Login
- `GET /api/profile` - Get profile (perlu token)
- `GET /api/get-presensi` - List presensi
- `POST /api/save-presensi` - Simpan presensi

---

## 🔧 Tips & Troubleshooting

### ❌ Error: "No Application Key"
Generate APP_KEY baru:
```bash
# Di local
php artisan key:generate --show

# Copy hasilnya (contoh: base64:abc123...)
# Paste ke Railway Variables → APP_KEY
```

### ❌ Error: "SQLSTATE Connection Refused"
Cek variables database:
- Pastikan format: `${{MySQL.MYSQLHOST}}` (bukan `${{MYSQLHOST}}`)
- Ganti `MySQL` dengan nama service MySQL kamu
- Atau manual copy dari tab Variables MySQL service

### ❌ Error: "404 Not Found"
```bash
# Tambahkan di Railway Variables:
APP_URL=https://your-app.up.railway.app

# Atau rebuild cache via Railway CLI:
railway run php artisan config:clear
```

### 📊 Monitoring
- Railway Dashboard → tab "Metrics" (CPU, Memory, Requests)
- Tab "Logs" untuk real-time logs
- Free tier: $5 credit = ±500 jam (cukup 24/7 untuk app kecil)

### 💰 Cost Estimation
- Small API (10-50 req/min): ~$2-3/bulan
- Medium API (100-200 req/min): ~$4-5/bulan
- Jika over, service akan sleep sampai bulan depan

### 🔄 Auto-Deploy
Setelah setup, setiap `git push` ke GitHub akan auto-deploy ke Railway ✅

### 📱 Connect ke Frontend/Mobile App
Ganti base URL di aplikasi frontend/mobile kamu dengan:
```
https://your-app.up.railway.app/api
```

---

## 🎉 Selamat!

API kamu sekarang production-ready dan accessible dari mana saja!

**Next Steps:**
- Setup custom domain (opsional)
- Add Redis untuk caching (opsional)
- Setup monitoring dengan Sentry (opsional)
- Configure CORS untuk domain frontend

**Butuh bantuan?** 
- Railway Docs: https://docs.railway.app
- Laravel Docs: https://laravel.com/docs
- Lihat [DEPLOY.md](./DEPLOY.md) untuk advanced configuration

---

Made with ❤️
