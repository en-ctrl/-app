# 記帳 PWA

原 iOS SwiftUI 記帳專案已改為純 HTML / CSS / JavaScript 的漸層 Liquid Glass 風格 PWA。無需 Xcode、Node.js、後端或資料庫。

## 在 GitHub Pages 發布
1. 在 GitHub 建立一個新的 **Public** repository（例如 `ledger-pwa`）。
2. 將本資料夾內所有檔案上傳到 repository 根目錄（`index.html` 必須在最外層）。
3. 開啟 repository 的 **Settings → Pages**。
4. 在 **Build and deployment** 選擇 **Deploy from a branch**。
5. Branch 選 `main`、資料夾選 `/ (root)`，按 **Save**。
6. 等待部署完成，網址通常是 `https://你的GitHub帳號.github.io/ledger-pwa/`。

## 加到手機主畫面
- iPhone：用 Safari 開啟 GitHub Pages 網址 → 分享 →「加入主畫面」。
- Android：用 Chrome 開啟網址 → 選單 →「安裝應用程式」或「加到主畫面」。
- 桌面 Chrome / Edge：網址列的安裝圖示或瀏覽器選單 → 安裝。

## 功能
- 首頁餘額、今日收入／支出、本月收支與最近紀錄
- 新增收入／支出、分類、金額、日期、備註
- 分類支出統計、紀錄搜尋與刪除
- JSON 備份匯出、PDF 收支報表（每月摘要、支出分類、完整交易明細）、清除資料
- LocalStorage 本機保存、Service Worker 離線快取
- PWA manifest、獨立視窗顯示、主畫面圖示

## 資料與限制
所有交易資料存在使用者目前瀏覽器的 LocalStorage。清除瀏覽器網站資料、改用其他瀏覽器或裝置不會自動同步；建議定期使用「設定 → 匯出資料」備份，並可透過「設定 → PDF 報表（可選擇日期區間）」列印或另存為 PDF。GitHub Pages 只負責靜態網站託管，不會收到你的交易內容。

## 本機預覽
Service Worker 與安裝功能需要 HTTPS 或 localhost。可直接用 VS Code Live Server 預覽，或部署到 GitHub Pages。
