import asyncio
from pyppeteer import launch
import pyautogui
from pyvirtualdisplay import Display

# 方法1：使用 pyvirtualdisplay（推荐）
display = Display(visible=False, size=(1920, 1080))
display.start()

# PyAutoGUI 配置
pyautogui._pyautogui_x11._display = pyautogui._pyautogui_x11._display or None

# Pyppeteer
async def main():
    browser = await launch(
        headless=True,
        executablePath='/usr/bin/chromium-browser',
        args=['--no-sandbox', '--disable-setuid-sandbox']
    )
    # ... 你的代码
    page = await browser.newPage()
    await page.screenshot({'path': 'test.png'},fullPage=True)
    await browser.close()

asyncio.run(main())
