const WHATSAPP_NUMBER = '6282299842236'; // Replace with actual number

export function generateWhatsAppUrl(type: 'pakaian' | 'buket', productName: string): string {
  let message: string;
  
  if (type === 'pakaian') {
    message = `Halo Bu Tik, saya tertarik dengan koleksi pakaian: ${productName}. Apakah model ini masih tersedia di toko?`;
  } else {
    message = `Halo Bu Tik, saya ingin konsultasi pemesanan buket model: ${productName}.`;
  }
  
  return `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
}

export function getGeneralWhatsAppUrl(): string {
  const message = 'Halo Bu Tik, saya ingin bertanya tentang produk di Galeri Tik.';
  return `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
}
