-- ============================================================
-- Galeri Tik — Database Setup Script
-- Run this in your Supabase SQL Editor
-- ============================================================

-- 1. TABEL KATEGORI UTAMA
CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(50) UNIQUE NOT NULL,
    name_id VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABEL MEREK / TEKS BERJALAN (BRAND MARQUEE)
CREATE TABLE IF NOT EXISTS brands_ticker (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    brand_name VARCHAR(100) NOT NULL,
    display_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABEL PRODUK
CREATE TABLE IF NOT EXISTS products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    sub_category VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    thumbnail_url TEXT NOT NULL,
    gallery_urls TEXT[] DEFAULT '{}',
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes untuk optimasi query
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_featured ON products(is_featured);

-- ============================================================
-- 4. ROW LEVEL SECURITY (RLS)
-- Hanya mengizinkan SELECT untuk anonim
-- ============================================================

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE brands_ticker ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Policy: Read-only for anonymous users
CREATE POLICY "Allow public read on categories"
  ON categories FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Allow public read on brands_ticker"
  ON brands_ticker FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Allow public read on products"
  ON products FOR SELECT
  TO anon
  USING (true);

-- ============================================================
-- 5. SEED DATA — Kategori Utama
-- ============================================================

INSERT INTO categories (slug, name_id) VALUES
  ('pakaian', 'Koleksi Pakaian'),
  ('buket', 'Galeri Buket')
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- 6. SEED DATA — Brand Marquee
-- ============================================================

INSERT INTO brands_ticker (brand_name, display_order) VALUES
  ('Zara', 1),
  ('Nevada', 2),
  ('Produk Impor', 3),
  ('Koleksi Lokal Pilihan', 4),
  ('Aksesoris Mode', 5),
  ('Koleksi Terbaru', 6),
  ('Busana Pesta', 7),
  ('Fashion Harian', 8);

-- ============================================================
-- 7. SEED DATA — Sample Products (Pakaian)
-- ============================================================

DO $$
DECLARE
  pakaian_id UUID;
  buket_id UUID;
BEGIN
  SELECT id INTO pakaian_id FROM categories WHERE slug = 'pakaian';
  SELECT id INTO buket_id FROM categories WHERE slug = 'buket';

  -- Sample Pakaian Products
  INSERT INTO products (category_id, sub_category, title, description, thumbnail_url, is_featured) VALUES
    (pakaian_id, 'Gamis', 'Gamis Syari Elegan Tosca', 'Gamis syari dengan detail bordir cantik, bahan adem dan nyaman dipakai sehari-hari.', 'https://placehold.co/400x533/ec4899/ffffff?text=Gamis+Tosca', true),
    (pakaian_id, 'Gamis', 'Gamis Brukat Premium', 'Gamis brukat mewah cocok untuk acara pesta dan pengajian.', 'https://placehold.co/400x533/be185d/ffffff?text=Gamis+Brukat', true),
    (pakaian_id, 'Daster', 'Daster Batik Jumbo', 'Daster batik ukuran jumbo, bahan katun adem.', 'https://placehold.co/400x533/f472b6/ffffff?text=Daster+Batik', false),
    (pakaian_id, 'Kulot', 'Kulot Plisket Premium', 'Kulot plisket bahan premium, elastis dan nyaman.', 'https://placehold.co/400x533/9d174d/ffffff?text=Kulot+Plisket', true),
    (pakaian_id, 'Rok', 'Rok A-Line Polos', 'Rok A-Line simpel dan elegan untuk berbagai acara.', 'https://placehold.co/400x533/831843/ffffff?text=Rok+A-Line', false),
    (pakaian_id, 'Celana', 'Celana Palazzo Wanita', 'Celana palazzo longgar dan stylish untuk tampil modis.', 'https://placehold.co/400x533/fbcfe8/333333?text=Celana+Palazzo', true),
    (pakaian_id, 'Koko', 'Baju Koko Modern Putih', 'Baju koko modern minimalis warna putih, cocok untuk ibadah dan acara formal.', 'https://placehold.co/400x533/ec4899/ffffff?text=Koko+Putih', true),
    (pakaian_id, 'Kemeja', 'Kemeja Flanel Kotak', 'Kemeja flanel motif kotak, bahan tebal dan nyaman.', 'https://placehold.co/400x533/f9a8d4/333333?text=Kemeja+Flanel', false),
    (pakaian_id, 'Kaos', 'Kaos Polos Premium Cotton', 'Kaos polos bahan cotton combed 30s, lembut di kulit.', 'https://placehold.co/400x533/fce7f3/333333?text=Kaos+Polos', false),
    (pakaian_id, 'Tas', 'Tas Selempang Mini', 'Tas selempang mini elegan untuk gaya kasual.', 'https://placehold.co/400x533/db2777/ffffff?text=Tas+Mini', true),
    (pakaian_id, 'Bros', 'Bros Mutiara Elegant', 'Bros mutiara cantik untuk mempercantik hijab.', 'https://placehold.co/400x533/fdf2f8/333333?text=Bros+Mutiara', false);

  -- Sample Buket Products
  INSERT INTO products (category_id, sub_category, title, description, thumbnail_url, is_featured) VALUES
    (buket_id, 'Buket Bunga', 'Buket Mawar Merah Classic', 'Buket mawar merah klasik, cocok untuk hadiah romantis dan anniversary.', 'https://placehold.co/400x533/dc2626/ffffff?text=Buket+Mawar', true),
    (buket_id, 'Buket Bunga', 'Buket Lily Putih Elegant', 'Rangkaian bunga lily putih elegan untuk momen spesial.', 'https://placehold.co/400x533/f3f4f6/333333?text=Buket+Lily', true),
    (buket_id, 'Buket Uang', 'Buket Uang 50 Lembar', 'Buket uang kreatif dengan 50 lembar, cocok untuk hadiah wisuda.', 'https://placehold.co/400x533/16a34a/ffffff?text=Buket+Uang+50', true),
    (buket_id, 'Buket Uang', 'Buket Uang Premium 100 Lembar', 'Buket uang premium dengan 100 lembar lipatan cantik.', 'https://placehold.co/400x533/15803d/ffffff?text=Buket+Uang+100', true),
    (buket_id, 'Buket Wisuda', 'Buket Wisuda Sunflower', 'Buket wisuda dengan bunga matahari ceria untuk kelulusan.', 'https://placehold.co/400x533/eab308/333333?text=Buket+Wisuda', true),
    (buket_id, 'Buket Ulang Tahun', 'Buket Ulang Tahun Rainbow', 'Buket colorful spesial ulang tahun dengan aneka bunga segar.', 'https://placehold.co/400x533/8b5cf6/ffffff?text=Buket+Birthday', true),
    (buket_id, 'Buket Snack', 'Buket Snack Coklat', 'Buket snack berisi aneka coklat dan permen favorit.', 'https://placehold.co/400x533/92400e/ffffff?text=Buket+Snack', false),
    (buket_id, 'Buket Bunga', 'Buket Tulip Pink Pastel', 'Rangkaian tulip pink pastel yang lembut dan cantik.', 'https://placehold.co/400x533/f9a8d4/333333?text=Buket+Tulip', false);
END $$;
