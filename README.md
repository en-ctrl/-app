# 記帳 App（iOS SwiftUI / Liquid Glass）

## 開啟與執行
1. 在 Mac 安裝並開啟 Xcode（建議 Xcode 16 或更新版本）。
2. 解壓縮資料夾，雙擊 `BookkeepingApp.xcodeproj`。
3. 在 Xcode 上方選擇 iPhone Simulator，或連接自己的 iPhone。
4. 第一次使用真機時，在 Signing & Capabilities 選擇自己的 Apple 開發者 Team，並將 Bundle Identifier 改成唯一值。
5. 按 ▶ Run 執行。

最低部署版本：iOS 17。iOS 26 會使用原生 Liquid Glass；較舊系統使用相容的 Material 樣式。

## 目前功能
- 首頁餘額、今日收支、本月收支、最近交易
- 新增收入／支出、金額、分類、日期時間、備註
- 統計、搜尋、滑動刪除
- UserDefaults 本機儲存
- 系統明暗模式
- 首頁齒輪可前往設定，「查看全部」可前往搜尋

## 尚未完成
- 設定中的 PDF 匯出目前是說明介面，尚未產生 PDF 檔。
- 資料僅存在目前裝置的 App 本機空間，尚無 iCloud 同步或帳號備份。
