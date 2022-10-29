---
sort: 6
---
## 研發參與者清單

威注音只聲稱過「截至目前為止在功能多樣性方面最強的第三方免費 macOS 系統專用輸入法」，這裡並未提到「第一」。已經使用頂點算法的的小麥注音才是（C++ 技術層面上的）第一。但威注音 2.8.0 版開始內建的田所選字窗，可能還真的是獨家體驗。

### macOS 版威注音專案目前僅用到 OpenVanilla for Mac 的下述程式組件（MIT License）：

- 僅供研發人員調試方便而使用的 App 版安裝程式 (by Lukhnos Liu & MJHsieh)，不對公眾使用。

威注音專案目前還用到如下的來自 Lukhnos Liu 的算法：

- 半衰記憶模組 MK2，被 Shiki Suen 用 Swift 重寫。
- 基於 Gramambular 2 組字引擎的算法、被 Shiki Suen 用 Swift 重寫（詳見 [Megrez 組字引擎](https://github.com/vChewing/Megrez)）。

### macOS 版威注音專案也使用了下述第三方模組：

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
- PanStar 與 Ryan Wu 對威注音的宣傳支援。
