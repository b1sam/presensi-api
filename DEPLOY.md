# Deploy ke Railway

## Langkah Deploy:

### 1. Setup Railway Account
- Buka https://railway.app
- Sign up dengan GitHub (gratis)
- Dapat $5 credit/bulan (cukup untuk API kecil)

### 2. Install Railway CLI (Opsional)
```bash
npm i -g @railway/cli
railway login
```

### 3. Deploy dari GitHub (Recommended)

#### A. Push ke GitHub dulu:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/username/presensi-backend.git
git push -u origin main
```

#### B. Di Railway Dashboard:
1. Klik "New Project"
2. Pilih "Deploy from GitHub repo"
3. Pilih repository kamu
4. Railway akan auto-detect Laravel

### 4. Setup Database di Railway
1. Di project dashboard, klik "New" → "Database" → "Add MySQL"
2. Railway akan auto-generate kredensial database
3. Copy kredensial ke environment variables

### 5. Set Environment Variables di Railway
Klik "Variables" tab, tambahkan:

```env
APP_NAME=Presensi API
APP_ENV=production
APP_KEY=base64:5ezJPBFzxot9ncSMMxB7eUSgz1Rtk8MiHst6ME5USvA=
APP_DEBUG=false
APP_URL=${{RAILWAY_PUBLIC_DOMAIN}}

DB_CONNECTION=mysql
DB_HOST=${{MYSQLHOST}}
DB_PORT=${{MYSQLPORT}}
DB_DATABASE=${{MYSQLDATABASE}}
DB_USERNAME=${{MYSQLUSER}}
DB_PASSWORD=${{MYSQLPASSWORD}}

SESSION_DRIVER=cookie
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```

**Note:** Railway auto-inject variable database MySQL jika kamu add MySQL service.

### 6. Generate APP_KEY Baru (Penting!)
```bash
php artisan key:generate --show
```
Copy hasilnya ke Railway environment variable `APP_KEY`

### 7. Enable Public Domain
1. Di Railway dashboard → Settings
2. Scroll ke "Networking"
3. Klik "Generate Domain"
4. Akan dapat URL: `https://presensi-backend-production.up.railway.app`

### 8. Testing API
```bash
curl https://your-app.railway.app/api/health
```

## Deploy via Railway CLI (Alternatif)

```bash
# Login
railway login

# Link project
railway link

# Deploy
railway up

# Set variables
railway variables set APP_ENV=production

# Open dashboard
railway open
```

## Tips:

### Free Tier Limits:
- $5 credit/bulan
- ≈ 500 jam execution (cukup untuk always-on 24/7 app kecil)
- Jika habis, service sleep sampai bulan depan

### Optimasi Cost:
1. Set `APP_DEBUG=false` untuk production
2. Gunakan cache: `php artisan config:cache`
3. Optimasi database queries
4. Tambah Redis untuk caching (opsional)

### Custom Domain (Opsional):
1. Beli domain di Namecheap/Cloudflare
2. Di Railway Settings → Networking → Custom Domain
3. Tambahkan CNAME record ke domain kamu

## Troubleshooting:

### Error: "No APP_KEY"
```bash
php artisan key:generate --show
# Copy hasil ke Railway variables
```

### Error: "SQLSTATE[HY000]"
- Pastikan MySQL service sudah running
- Cek environment variables DB_* sudah benar
- Railway auto-inject variables: `${{MYSQLHOST}}`, dll

### Error: "Route not found"
```bash
php artisan route:cache
git add . && git commit -m "fix routes" && git push
```

### Logs:
Lihat logs di Railway dashboard atau via CLI:
```bash
railway logs
```

## Monitoring:

Railway dashboard menampilkan:
- CPU & Memory usage
- Request metrics
- Deployment history
- Logs real-time

## Backup Database:

```bash
# Via Railway CLI
railway connect MySQL
# Atau export via phpMyAdmin jika perlu
```

## Alternative Platform (jika Railway trial habis):

1. **Render.com** - Free tier 750 jam/bulan
2. **Fly.io** - Free tier 3 shared-cpu instances
3. **Heroku** - $5/bulan (no free tier anymore)
4. **DigitalOcean App Platform** - $5/bulan
5. **AWS/GCP** - Free tier 12 bulan

---

Made with ❤️ for Presensi Backend API
