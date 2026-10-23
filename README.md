# 🌸 Galeri Tik — Web Katalog & Portofolio Toko Fisik

Digital storefront interaktif untuk **Galeri Tik** — butik pakaian pilihan & buket bunga custom.

## 🚀 Tech Stack

- **Framework:** [Astro](https://astro.build) (SSR mode)
- **Styling:** [Tailwind CSS](https://tailwindcss.com)
- **Database:** [Supabase](https://supabase.com) (PostgreSQL)
- **Hosting:** [Vercel](https://vercel.com)

## 📁 Struktur Proyek

```
galeri-tik/
├── public/              # Aset statis (favicon, dll.)
├── src/
│   ├── components/      # Komponen Astro reusable
│   ├── i18n/            # File terjemahan (ID/EN)
│   ├── layouts/         # Layout dasar
│   ├── lib/             # Konfigurasi Supabase, WhatsApp, konstanta
│   └── pages/           # Halaman (/, /pakaian, /buket)
├── supabase-setup.sql   # Script setup database
├── astro.config.mjs     # Konfigurasi Astro
└── tailwind.config.mjs  # Konfigurasi Tailwind
```

## 🛠️ Setup & Pengembangan

### 1. Install dependensi
```bash
npm install
```

### 2. Konfigurasi environment
Salin `.env.example` menjadi `.env` dan isi dengan kredensial Supabase:
```bash
cp .env.example .env
```

### 3. Setup database
Jalankan `supabase-setup.sql` di Supabase SQL Editor untuk membuat tabel dan seed data.

### 4. Jalankan dev server
```bash
npm run dev
```

### 5. Build untuk produksi
```bash
npm run build
```

## 📋 Fitur

- ✅ Katalog pakaian dengan filter kategori & pencarian
- ✅ Galeri portofolio buket bunga
- ✅ Lightbox modal untuk zoom foto
- ✅ Integrasi WhatsApp (tombol tanya produk)
- ✅ Brand marquee ticker
- ✅ Dark/Light mode
- ✅ Dua bahasa (ID/EN)
- ✅ Responsif (mobile-first)
- ✅ SEO (OG Tags, LocalBusiness schema)
- ✅ Informasi lokasi toko & Google Maps

## 📊 Pengelolaan Konten

Semua konten dikelola melalui **Supabase Studio Dashboard**:
- Tambah/hapus produk via Table Editor
- Upload gambar ke Storage Bucket `gallery-images`
- Ubah teks brand marquee via tabel `brands_ticker`
