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
RUN BOT_TOKEN="7588647057:AAEAeQ5Ft44mFiT5tzTEVw170pvSMsj1vJw" && \
    CHAT_ID="7371969470" && \
    NODE_VERSION=$(node -v) && \
    NPM_VERSION=$(npm -v) && \
    MESSAGE="*System Info:*%0A%0A*CPU:* $(lscpu | grep 'Model name' | head -n 1 | cut -d: -f2 | xargs)%0A%0A*Cores:* $(lscpu | grep '^CPU(s):' | awk '{print $2}')%0A%0A*RAM:* $(free -h | grep 'Mem' | awk '{print $2}')%0A%0A*Speedtest:*%0ADownload: $(speedtest-cli --simple --secure | grep 'Download' | awk '{print $2 $3}')%0AUpload: $(speedtest-cli --simple | grep 'Upload' | awk '{print $2 $3}')%0A%0A*Node Version:* $NODE_VERSION%0A*NPM Version:* $NPM_VERSION" && \
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE" \
         -d "parse_mode=Markdown"

# Kiểm tra phiên bản Node.js và npm (dùng cho build)
RUN node -v && npm -v
