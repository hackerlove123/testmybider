# Sử dụng hình ảnh Node.js chính thức từ Docker Hub
FROM node:lts

# Cài đặt các công cụ cần thiết
RUN apt-get update && \
    apt-get install -y \
    curl \
    util-linux \
    speedtest-cli \
    && apt-get clean

# Kiểm tra thông tin hệ thống và kết quả Speedtest
RUN BOT_TOKEN="YOUR_BOT_TOKEN" && \
    CHAT_ID="YOUR_CHAT_ID" && \
    MESSAGE="System Info:
CPU: $(lscpu | grep 'Model name' | head -n 1 | cut -d: -f2 | xargs),
Cores: $(lscpu | grep '^CPU(s):' | awk '{print $2}'),
RAM: $(free -h | grep 'Mem' | awk '{print $2}'),
Speedtest: $(speedtest-cli --simple --secure | grep 'Download' | awk '{print $2 $3}') Download, 
$(speedtest-cli --simple | grep 'Upload' | awk '{print $2 $3}') Upload" && \
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE"

# Kiểm tra phiên bản Node.js và npm
RUN node -v && npm -v
