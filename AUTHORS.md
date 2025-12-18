---
sort: 7
---
## 研發參與者清單

唯音只聲稱過「截至目前為止在功能多樣性方面最強的第三方免費 macOS 系統專用輸入法」。

本文針對唯音 4.2.2 的情況做過修訂。

### macOS 版唯音專案目前僅用到 OpenVanilla for Mac 的下述程式組件（MIT License）：

- Aqua 紀念版限定：僅供研發人員調試方便而使用的 App 版安裝程式 (by Lukhnos Liu & MJHsieh)，不對公眾使用。

### macOS 版唯音專案也使用了下述第三方模組：

- LineReader: (c) 2019 and onwards Robert Muckle-Jones (Apache 2.0 License).
- SwiftUI VDKComboBox: (c) 2022 and onwards Bryan Jones (CC BY-SA 4.0)
- 步天歌繁簡轉換引擎，源自 Nick Chen 用 MIT License 發行的 Objective-C 框架「NCChineseConverter」，被 Shiki Suen 以 Swift 語言徹底重寫、且改用了 plist 作為資料存儲格式。
    - 該繁簡轉換引擎僅用作就地加詞時對「非當前繁簡模式」的使用者辭典的內容寫入。

### 下述人員參與 macOS 版 vChewing 研發：

- Shiki Suen:
  - 專案創始人，亦是現任專案維護者，鐵恨注拼引擎作者，天權星組字引擎作者，步天歌繁簡轉換引擎維護者。
- Hiraku Wang (僅參與唯音 v1.x):
  - 唯音專案早期內部研發階段時的 Objective-C & C++ 技術支援。
  - 也製作了唯音目前的介面語言切換系統（XIB 版本）。
- Isaac Xen (僅參與唯音 v1.x):
  - 唯音早期版本的音效系統研發。
  - 針對 Swift 語言的 StringView 擴展（該技術現用於使用者自訂語彙檔案的快速讀取）。

### 特別鳴謝:

- 所有對唯音輸入法的研發給予過精神鼓勵的人士們。
- PanStar 與 Ryan Wu 對唯音的宣傳支援。
