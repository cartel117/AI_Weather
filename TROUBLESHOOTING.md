# Flutter Shader 編譯錯誤解決方案

## 問題
```
ShaderCompilerException: Shader compilation of "stretch_effect.frag" failed
Could not write file to build\flutter_assets\shaders/stretch_effect.frag
```

## 已執行的解決步驟

### 1. 清理專案 ✅
```bash
flutter clean
```

### 2. 重新獲取依賴 ✅
```bash
flutter pub get
```

### 3. 重新生成程式碼 ✅
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 如果問題持續，請嘗試：

### 方案 1: 以管理員權限運行
1. 右鍵點擊 PowerShell 或 VS Code
2. 選擇「以系統管理員身分執行」
3. 重新執行 `flutter run`

### 方案 2: 檢查防毒軟體
- 暫時停用防毒軟體或將專案資料夾加入白名單
- 特別是 Windows Defender 可能會阻擋檔案寫入

### 方案 3: 刪除並重建 build 資料夾
```powershell
Remove-Item -Recurse -Force build
flutter clean
flutter pub get
```

### 方案 4: 升級 Flutter
```bash
flutter upgrade
```

### 方案 5: 檢查磁碟空間
確保 D: 磁碟有足夠的可用空間

### 方案 6: 使用不同的裝置/模擬器
```bash
# 查看可用裝置
flutter devices

# 指定裝置運行
flutter run -d <device-id>
```

## 當前狀態
- ✅ Flutter clean 已完成
- ✅ 依賴套件已重新安裝
- 🔄 build_runner 正在生成程式碼

## 下一步
等待 build_runner 完成後，執行：
```bash
flutter run
```
