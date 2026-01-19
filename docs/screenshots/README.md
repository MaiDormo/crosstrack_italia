# Screenshots

Add your app screenshots here:

1. **map_view.png** — Main map screen showing track markers
2. **track_details.png** — Track detail panel with info and reviews  
3. **track_list.png** — List/grid view of tracks

## How to capture

On Android emulator or device:
```bash
adb exec-out screencap -p > screenshot.png
```

On iOS Simulator:
```bash
xcrun simctl io booted screenshot screenshot.png
```

On Web (Chrome DevTools):
1. Open DevTools (F12)
2. Toggle device toolbar (Ctrl+Shift+M)
3. Select a mobile device
4. Right-click → "Capture screenshot"

Recommended size: 1080x1920 (or similar mobile resolution)
