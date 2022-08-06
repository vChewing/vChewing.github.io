---
nav_order: 100
---
## 研發參與者清單

威注音只聲稱過「截至目前為止在功能多樣性方面最強的第三方免費 macOS 系統專用輸入法」，這裡並未提到「第一」。已經使用頂點算法的的小麥注音才是（C++ 技術層面上的）第一。

### macOS 版威注音用到了下述來自上游的內容，然上游並無義務對此做任何評論：

- Zonble Yang:
    - macOS 版小麥注音 2.x 主程式暨架構師。
    - 將狀態模式與策略模式相互結合的設計模式。
    - Voltaire 選字窗 MK2。
        - 在威注音專案內被大量修改，以支援諸如頁碼顯示等威注音獨佔功能。
    - InputSignal 按鍵輸入訊號包裝機制。
    - 飄雲通知視窗與工具提示（均在威注音專案內有美術改動）。
    - (NS)StringUtils，用來做 UTF8-UTF16 字串長度換算。
    - FSEventStreamHelper，用來監視使用者辭典目錄內的變化。
    - 以 App 作為封裝形式的安裝包（僅用作內部研發測試之用途）。
    - InputSource Helper，負責協助輸入法在 macOS 系統內的自動啟用流程。
    - mgrPrefs 使用者偏好設定參數管理模組。
    - apiUpdate 軟體新版本自動檢查模組。
- Mengjuei Hsieh:
    - macOS 版小麥注音 1.x 主程式暨架構師。
    - 使用者半衰記憶模組的原始 C++ 版的設計者。
        - Shiki Suen 完成了該模組的 Swift / C# 重寫、以及在此之上的後繼開發。

之前是 C++ 但在威注音專案被使用 Swift 重寫的內容，均在對應的檔案開頭有相關的標記。

威注音專案內已經沒有任何劉燈的 C++ 程式碼了，但還是需要 Credit 一下：

- Lukhnos Liu:
    - Gramambular v1 組字引擎 (自 vChewing 1.5.4 起被換成天權星組字引擎)。
        - Shiki Suen 將 Gramambular 2 用 Swift 語言重寫重構，更名「天權星 Megrez」繼續維護開發。
            - Initially rebranded from (c) Lukhnos Liu's C++ library "Gramambular 2" (MIT License).
            - Swiftified // CSharpened and further development by (c) 2022 and onwards The vChewing Project (MIT-NTL License).
    - Mandarin 注拼引擎 (自 vChewing 1.5.7 起被換成自家的鐵恨注拼引擎)。
        - 鐵恨注拼引擎乃 Shiki Suen 從零開始重新設計開發的注拼並擊處理引擎，可支援注音組合矯正、多種拼音種類輸入支援等特色功能。
            - 鐵恨引擎全部著作權所有：(c) 2022 and onwards The vChewing Project (MIT-NTL License).

### macOS 版威注音專案使用了下述第三方模組：

- ShiftKeyUpChecker: (c) 2019 and onwards Qwertyyb (March Yang) (MIT License).
- LineReader: (c) 2019 and onwards Robert Muckle-Jones (Apache 2.0 License).
- SwiftUI Preferences UI Framework: (c) 2018 and onwards Sindre Sorhus (MIT License).
- SwiftUI VDKComboBox: (c) 2022 and onwards Bryan Jones (CC BY-SA 4.0)
- 步天歌繁簡轉換引擎，源自 Nick Chen 用 MIT License 發行的 Objective-C 框架「NCChineseConverter」，被 Shiki Suen 以 Swift 語言徹底重寫、且改用了 plist 作為資料存儲格式。
    - 該繁簡轉換引擎僅用作就地加詞時對「非當前繁簡模式」的使用者辭典的內容寫入。

### 下述人員參與 macOS 版 vChewing 研發：

- Shiki Suen:
  - 現任專案維護者，鐵恨注拼引擎作者，天權星組字引擎維護者，步天歌繁簡轉換引擎維護者。
- Hiraku Wang:
  - 威注音專案早期內部研發階段時的 Objective-C & C++ 技術支援。
  - 也製作了威注音目前的介面語言切換系統（XIB 版本）。
- Isaac Xen:
  - 威注音早期版本的音效系統研發。
  - 針對 Swift 語言的 StringView 擴展（該技術現用於使用者自訂語彙檔案的快速讀取）。

### 特別鳴謝:

- 所有對威注音輸入法的研發給予過精神鼓勵的人士們。
