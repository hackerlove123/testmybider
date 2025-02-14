# Sử dụng hình ảnh Node.js chính thức từ Docker Hub
FROM node:lts

# Cài đặt và chạy các lệnh kiểm tra phiên bản
CMD ["sh", "-c", "node -v && npm -v"]
