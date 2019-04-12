import pyautogui
import time

time.sleep(10)
# pyautogui.keyDown('w')
pyautogui.keyDown('space')

# stop by moving mouse to upper-left corner
while True:
    pyautogui.click(100, 100)
    print('clicked')
