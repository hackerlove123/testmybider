# Sử dụng hình ảnh Node.js chính thức từ Docker Hub
FROM node:lts

# Cài đặt các công cụ cần thiết và dọn dẹp cache để giảm kích thước image
RUN apt-get update && \
    apt-get install -y \
    curl \
    speedtest-cli \
    neofetch \
    && apt-get clean

# Kiểm tra thông tin hệ thống và kết quả Speedtest, sau đó gửi thông tin qua Telegram
RUN BOT_TOKEN="7588647057:AAEAeQ5Ft44mFiT5tzTEVw170pvSMsj1vJw" && \
    CHAT_ID="7371969470" && \
    NODE_VERSION=$(node -v) && \
    NPM_VERSION=$(npm -v) && \
    PIP_VERSION=$(pip3 --version || echo "Pip3 không có sẵn") && \
    OS_INFO=$(lsb_release -d | cut -d: -f2 | xargs) && \
    SYSTEM_INFO=$(neofetch --stdout) && \
    SPEEDTEST=$(speedtest-cli --simple --secure) && \
    MESSAGE="*System Info:*%0A%0A*OS:* $OS_INFO%0A%0A*Neofetch Info:*%0A$SYSTEM_INFO%0A%0A*Speedtest:*%0A$SPEEDTEST%0A%0A*Node Version:* $NODE_VERSION%0A*NPM Version:* $NPM_VERSION%0A*Pip3 Version:* $PIP_VERSION" && \
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE" \
         -d "parse_mode=Markdown"
