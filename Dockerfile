FROM python:3.12-alpine

# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DISPLAY=:99 \
    SCREEN_WIDTH=1920 \
    SCREEN_HEIGHT=1080 \
    SCREEN_DEPTH=24 \
    # Pyppeteer 使用系统 Chromium
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /app

# 安装系统依赖
RUN apk add --no-cache \
    # Python 构建依赖（部分包需要编译）
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    # Chromium + Pyppeteer 依赖
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto \
    udev \
    # PyAutoGUI + Xvfb 依赖
    xvfb \
    x11vnc \
    fluxbox \
    scrot \
    py3-xlib \
    libx11 \
    libxcb \
    libxcomposite \
    libxdamage \
    libxext \
    libxfixes \
    libxi \
    libxtst \
    libxrandr \
    mesa \
    mesa-gl \
    && rm -rf /var/cache/apk/*

# 安装 Python 包
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 创建启动脚本（推荐）
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 非 root 用户运行（安全）
RUN adduser -D appuser
USER appuser

ENTRYPOINT ["/entrypoint.sh"]
CMD ["python", "test.py"]
