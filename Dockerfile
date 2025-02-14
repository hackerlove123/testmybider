# Sử dụng hình ảnh Node.js chính thức từ Docker Hub
FROM node:lts

# Cài đặt các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y \
    curl \
    lscpu \
    speedtest-cli \
    && apt-get clean

# Kiểm tra thông tin hệ thống và kết quả Speedtest trên một dòng
RUN echo -e "System Info:\nCPU: $(lscpu | grep 'Model name' | head -n 1), Cores: $(lscpu | grep '^CPU(s):' | awk '{print $2}'), RAM: $(free -h | grep 'Mem' | awk '{print $2}'), Speedtest: $(speedtest-cli --simple | grep 'Download' | awk '{print $2 $3}') Download, $(speedtest-cli --simple | grep 'Upload' | awk '{print $2 $3}') Upload" && \
    node -v && npm -v
