#!/bin/sh

# 启动 Xvfb（虚拟显示）
Xvfb :99 -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH} -ac &

# 等待 Xvfb 启动
sleep 2

# 可选：启动 fluxbox（窗口管理器）
fluxbox > /dev/null 2>&1 &

exec "$@"
