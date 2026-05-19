/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: 'standalone', 
  
  // 🚀 ÉP CỨNG ĐỂ ĐÓNG GÓI DOCKER LUÔN LUÔN ĂN LUỒNG PHÂN LÀN K8S
  assetPrefix: '/admin-assets',
};

module.exports = nextConfig;