# GitHub 上傳指南

## 📋 準備工作

### 1. 確保已安裝 Git
```bash
git --version
```

如果未安裝，請到 [Git 官網](https://git-scm.com/) 下載安裝。

### 2. 配置 Git（首次使用）
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 🚀 上傳步驟

### 方法一：使用 PowerShell 命令行

#### Step 1: 初始化 Git 倉庫
```powershell
cd d:\Project\ai_weather
git init
```

#### Step 2: 添加所有文件
```powershell
git add .
```

#### Step 3: 提交更改
```powershell
git commit -m "Initial commit: AI Weather App with MVVM architecture"
```

#### Step 4: 在 GitHub 創建新倉庫
1. 登入 [GitHub](https://github.com)
2. 點擊右上角 "+" → "New repository"
3. 填寫：
   - Repository name: `ai_weather`
   - Description: `A modern Flutter weather app with MVVM architecture`
   - 選擇 Public 或 Private
   - **不要**勾選 "Initialize with README"（因為本地已有）
4. 點擊 "Create repository"

#### Step 5: 連接遠程倉庫並推送
```powershell
# 替換 YOUR_USERNAME 為您的 GitHub 用戶名
git remote add origin https://github.com/YOUR_USERNAME/ai_weather.git
git branch -M main
git push -u origin main
```

### 方法二：使用 GitHub Desktop（圖形界面）

#### Step 1: 下載並安裝
- 下載：[GitHub Desktop](https://desktop.github.com/)

#### Step 2: 添加本地倉庫
1. 打開 GitHub Desktop
2. File → Add Local Repository
3. 選擇 `d:\Project\ai_weather`
4. 點擊 "Create a repository"

#### Step 3: 提交更改
1. 在左側看到所有變更的文件
2. 在下方輸入 commit 訊息：`Initial commit: AI Weather App`
3. 點擊 "Commit to main"

#### Step 4: 發布到 GitHub
1. 點擊 "Publish repository"
2. 選擇名稱和描述
3. 選擇 Public 或 Private
4. 點擊 "Publish repository"

## 📝 建議的 Commit 訊息

```bash
# 初始提交
git commit -m "Initial commit: AI Weather App with MVVM architecture

- Implemented MVVM architecture with Factory Pattern
- Integrated go_router for navigation
- Created 11 reusable components
- Added comprehensive documentation (2400+ lines)
- Features: Real-time weather data for Taiwan cities"
```

## 🔒 保護敏感資訊

### 檢查 API Key
確保 API Key 不會被上傳：

```powershell
# 檢查 api_constants.dart
cat lib/core/constants/api_constants.dart
```

如果包含真實的 API Key，請修改為：

```dart
class ApiConstants {
  static const String apiKey = String.fromEnvironment('CWB_API_KEY', 
    defaultValue: 'YOUR_API_KEY_HERE');
  // ... 其他代碼
}
```

然後添加到 .gitignore：
```
# API Keys (如果有單獨的配置文件)
lib/core/constants/api_keys.dart
.env
```

## 📦 推送後的檔案結構

GitHub 上會看到：
```
ai_weather/
├── .github/                 # GitHub workflows (可選)
├── android/
├── ios/
├── lib/                     # 主要代碼
├── test/
├── web/
├── windows/
├── linux/
├── macos/
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── README.md               ⭐ 專案說明
├── ARCHITECTURE.md         ⭐ 架構文檔
├── QUICKSTART.md          ⭐ 快速開始
├── MIGRATION_GUIDE.md     ⭐ 遷移指南
└── ... 其他文檔
```

## 🎯 後續更新

### 日常更新流程
```powershell
# 1. 查看更改
git status

# 2. 添加更改
git add .
# 或選擇性添加
git add lib/view/pages/new_page.dart

# 3. 提交更改
git commit -m "Add new feature: City search"

# 4. 推送到 GitHub
git push
```

### 創建分支（開發新功能）
```powershell
# 創建並切換到新分支
git checkout -b feature/city-search

# 開發完成後提交
git add .
git commit -m "Implement city search feature"

# 推送分支
git push -u origin feature/city-search

# 在 GitHub 上創建 Pull Request
```

## 🏷️ 添加標籤（版本發布）

```powershell
# 創建標籤
git tag -a v1.0.0 -m "Release version 1.0.0 - Initial release with MVVM architecture"

# 推送標籤
git push origin v1.0.0

# 推送所有標籤
git push --tags
```

## 📋 GitHub Repository 設置建議

### 1. 添加 Topics
在 GitHub repository 頁面添加相關標籤：
- `flutter`
- `dart`
- `mvvm`
- `weather-app`
- `go-router`
- `bloc`
- `freezed`
- `taiwan`

### 2. 設置 About
- Website: 您的應用網址（如果有）
- Description: `A modern Flutter weather app with MVVM architecture, Factory Pattern, and go_router`

### 3. 添加 License
建議添加 MIT License：
```powershell
# 在專案根目錄創建 LICENSE 文件
```

### 4. 啟用 GitHub Pages（展示文檔）
1. Settings → Pages
2. Source: Deploy from a branch
3. Branch: main → /docs
4. 可以展示您的架構文檔

## 🔧 常見問題

### Q: 推送時要求輸入密碼？
A: GitHub 已不支援密碼認證，請使用 Personal Access Token：
1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token
3. 勾選 `repo` 權限
4. 複製 token
5. 推送時使用 token 作為密碼

### Q: 文件太大無法推送？
A: 檢查 build/ 目錄是否被 .gitignore 排除：
```powershell
git rm -r --cached build/
git commit -m "Remove build directory"
```

### Q: 想要撤銷某些文件？
A:
```powershell
# 從暫存區移除（保留本地更改）
git reset HEAD <file>

# 撤銷本地更改
git checkout -- <file>
```

## 📱 展示您的專案

### 添加徽章到 README.md
在 README.md 頂部已經有徽章，推送後會自動顯示：
- Flutter 版本
- Dart 版本
- 架構類型
- License

### 添加截圖
在 GitHub 上傳截圖：
1. 創建 `screenshots/` 目錄
2. 添加應用截圖
3. 在 README.md 中引用

## ✅ 檢查清單

上傳前請確認：
- [ ] README.md 完整且清晰
- [ ] .gitignore 正確配置
- [ ] 沒有敏感資訊（API Keys, 密碼等）
- [ ] 所有文檔都已更新
- [ ] 代碼沒有編譯錯誤
- [ ] 已測試主要功能

## 🎉 完成！

上傳成功後，您的專案將出現在：
```
https://github.com/YOUR_USERNAME/ai_weather
```

可以分享給其他人：
- 📱 展示您的作品
- 🤝 接受貢獻
- 📚 作為學習資源
- 💼 加入您的作品集

---

**需要幫助？**
- [GitHub 官方文檔](https://docs.github.com/)
- [Git 教學](https://git-scm.com/book/zh-tw/v2)
