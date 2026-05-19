/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'standalone', // Giữ nguyên standalone để containerization tối ưu
  
  // 🚀 BỔ SUNG ĐỂ KHỬ BUG 404/XUNG ĐỘT FILE TĨNH VỚI STOREFRONT
  // Khi chạy Production trên cụm K8s, ép toàn bộ tệp tĩnh đi qua ngõ độc quyền /admin-assets
  assetPrefix: process.env.NODE_ENV === 'production' ? '/admin-assets' : '',
};

module.exports = nextConfig;