# 我的記帳本 — iOS Liquid Glass

這是一個 SwiftUI 的 iOS 記帳 App 原型，依照需求製作：

- 首頁 / 記帳 / 統計 / 搜尋 / 設定
- 支出與收入
- 金額、日期時間、備註、分類
- 早餐、交通、晚餐、學習、住宿、醫療、其他
- 本機儲存
- 首頁統計與最近交易
- 搜尋與刪除
- Liquid Glass：iOS 26 使用 `.glassEffect`，舊系統使用 `.ultraThinMaterial`
- App 外觀跟隨 iPhone 系統明暗設定
- 日系、素色、簡潔的 UI 方向

## 開啟方式

1. 使用 Xcode 建立一個 iOS App 專案。
2. 將 `BookkeepingApp` 資料夾中的 Swift 檔案加入專案 Target。
3. 建議 Deployment Target 設為 iOS 17.0；若要使用原生 Liquid Glass，請在 iOS 26 裝置／模擬器執行。
4. Run。

## 注意

這份 ZIP 是可直接放入 Xcode 的完整 SwiftUI 原始碼包，但目前沒有在本環境替你簽署或編譯成 `.ipa`；App Store / 真機安裝仍需要 Xcode 與 Apple 開發者簽署。
