# Sử dụng hình ảnh Node.js chính thức từ Docker Hub
FROM node:lts

# Kiểm tra phiên bản Node.js và npm trong quá trình build (không cần chạy container)
RUN node -v && npm -v
