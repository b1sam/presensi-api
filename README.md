# Presensi Backend API

Laravel REST API untuk sistem presensi/absensi.

## Features

- 🔐 Authentication (Register/Login) dengan Laravel Sanctum
- 👤 User Profile Management
- 📝 Presensi (Check-in/Check-out)
- 📊 Get Presensi History
- 🔒 Protected Routes dengan Token

## Tech Stack

- Laravel 8.x
- PHP 8.2
- MySQL
- Laravel Sanctum (API Authentication)
- CORS enabled

## API Endpoints

### Public Endpoints
```
POST   /api/register        - Register user baru
POST   /api/login           - Login user
GET    /api/health          - Health check
```

### Protected Endpoints (Perlu Token)
```
GET    /api/profile         - Get user profile
POST   /api/logout          - Logout user
GET    /api/get-presensi    - Get history presensi
POST   /api/save-presensi   - Simpan presensi baru
```

## Local Development

### Prerequisites
- PHP 8.2+
- Composer
- MySQL
- XAMPP/Laravel Valet/Laravel Herd

### Setup

1. Clone repository
```bash
git clone <repo-url>
cd presensi-backend-master
```

2. Install dependencies
```bash
composer install
```

3. Setup environment
```bash
cp .env.example .env
php artisan key:generate
```

4. Konfigurasi database di `.env`
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=presensi
DB_USERNAME=root
DB_PASSWORD=
```

5. Migrate database
```bash
php artisan migrate
```

6. Run server
```bash
php artisan serve
```

API akan jalan di `http://localhost:8000`

## Deploy ke Production

### 🚂 Railway (Recommended)

Railway memberikan $5 credit gratis per bulan (cukup untuk API kecil).

**Quick Deploy:**

1. **Persiapan Git**
```bash
git init
git add .
git commit -m "Initial commit"
```

2. **Push ke GitHub**
```bash
# Buat repo baru di GitHub
git remote add origin https://github.com/username/presensi-backend.git
git branch -M main
git push -u origin main
```

3. **Deploy di Railway**
   - Buka https://railway.app
   - Sign up dengan GitHub (gratis)
   - Klik "New Project" → "Deploy from GitHub"
   - Pilih repository kamu
   - Railway auto-detect Laravel ✅

4. **Add MySQL Database**
   - Di project dashboard: "New" → "Database" → "MySQL"
   - Railway auto-inject credentials

5. **Set Environment Variables**
   
   Klik tab "Variables", tambahkan:
   ```env
   APP_NAME=Presensi API
   APP_ENV=production
   APP_DEBUG=false
   APP_KEY=<generate baru dengan: php artisan key:generate --show>
   
   # Database (auto-inject by Railway)
   DB_CONNECTION=mysql
   DB_HOST=${{MYSQLHOST}}
   DB_PORT=${{MYSQLPORT}}
   DB_DATABASE=${{MYSQLDATABASE}}
   DB_USERNAME=${{MYSQLUSER}}
   DB_PASSWORD=${{MYSQLPASSWORD}}
   ```

6. **Generate Public Domain**
   - Settings → Networking → "Generate Domain"
   - Dapat URL: `https://presensi-backend-production.up.railway.app`

7. **Test API**
```bash
curl https://your-app.railway.app/api/health
```

**Lihat panduan lengkap:** [DEPLOY.md](./DEPLOY.md)

### Alternative Platforms:
- **Render.com** - 750 jam gratis/bulan
- **Fly.io** - Free tier tersedia
- **DigitalOcean** - $5/bulan

## Testing API

### Register
```bash
curl -X POST https://your-api.com/api/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }'
```

### Login
```bash
curl -X POST https://your-api.com/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

Response akan berisi `token` yang dipakai untuk protected endpoints.

### Get Profile (dengan token)
```bash
curl https://your-api.com/api/profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Save Presensi
```bash
curl -X POST https://your-api.com/api/save-presensi \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "latitude": "-6.200000",
    "longitude": "106.816666",
    "type": "masuk"
  }'
```

## Database Schema

### users
- id
- name
- email
- password
- timestamps

### presensi
- id
- user_id
- tanggal
- jam_masuk
- jam_keluar
- foto_masuk
- foto_keluar
- lokasi_masuk (lat,long)
- lokasi_keluar (lat,long)
- timestamps

## Security

- CORS enabled untuk frontend integration
- API routes protected dengan Sanctum middleware
- Password hashing dengan bcrypt
- Environment variables untuk sensitive data

## Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## License

Open source, silakan dipakai dan dikembangkan.

---

**Need help?** Lihat [DEPLOY.md](./DEPLOY.md) untuk panduan deployment lengkap.
