import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.SUPABASE_URL || '';
const supabaseAnonKey = import.meta.env.SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface Category {
  id: string;
  slug: string;
  name_id: string;
  created_at: string;
}

export interface BrandTicker {
  id: string;
  brand_name: string;
  display_order: number;
  is_active: boolean;
  created_at: string;
}

export interface Product {
  id: string;
  category_id: string;
  sub_category: string;
  title: string;
  description: string | null;
  thumbnail_url: string;
  gallery_urls: string[];
  is_featured: boolean;
  created_at: string;
}
