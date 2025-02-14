# Sử dụng image Node.js Alpine nhỏ gọn
FROM node:lts-alpine

# Cài đặt các công cụ cần thiết
RUN apk add --no-cache \
    curl \
    speedtest-cli

# Kiểm tra thông tin hệ thống và gửi qua Telegram
RUN BOT_TOKEN="7588647057:AAEAeQ5Ft44mFiT5tzTEVw170pvSMsj1vJw" && \
    CHAT_ID="7371969470" && \
    NODE_VERSION=$(node -v) && \
    NPM_VERSION=$(npm -v) && \
    PIP_VERSION=$(pip3 --version || echo "Pip3 không có sẵn") && \
    OS_INFO=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d= -f2 | tr -d '"') && \
    KERNEL_INFO=$(uname -r) && \
    SPEEDTEST=$(speedtest-cli --simple --secure) && \
    MESSAGE="*System Info:*%0A%0A*OS:* $OS_INFO%0A*Kernel:* $KERNEL_INFO%0A%0A*Speedtest:*%0A$SPEEDTEST%0A%0A*Node Version:* $NODE_VERSION%0A*NPM Version:* $NPM_VERSION%0A*Pip3 Version:* $PIP_VERSION" && \
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$MESSAGE" \
         -d "parse_mode=Markdown"
