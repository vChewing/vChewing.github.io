> ☕️ **唯音輸入法專案目前[正在接收贊助](https://vchewing.github.io/SPONSOR_ME.html)**，將用於年度維護更新、Apple 開發者年費等開銷。

#### 4.8.0 版針對 4.7.4 版更新了下述內容：

- 懶人包總結：組字區為空時敲 Shift+Space 的空格字元可設定改敲半形（預設仍為全形）；中英混打模式現於英數內容工具提示顯示當前可能拼出的注音；允許藉由 CLI 介面匯入 / 匯出 JSON 格式的偏好設定備份；專案改採 LGPLv3+MulanPSLv2 混合授權。
- 體驗：[所有發行版] 新增一個使用者自決選項、位於唯音輸入法偏好設定的「行為設定」頁面內：在組字區為空（什麼內容都沒打）的時候，敲 Shift+Space 敲出的空格字元現在可以設定成「改敲半形空格字元」。預設情況下，此時敲出來的仍是全形空格字元。
- 體驗：[所有發行版] 中英文混合輸入回退模式（也就是注音中英文混打模式）現在會在英數內容工具提示內顯示當前可能拼出來的注音。與工具提示有關的一些偏好設定或會使這些內容顯示成漢語拼音，全看使用者個人偏好。
- 體驗：[所有發行版] 允許藉由 CLI 介面匯入 / 匯出 JSON 格式的使用者偏好設定資料備份。
- 研發：[所有發行版] 從這一版開始，唯音輸入法讓主流發行版的倉庫擁有了對 Aqua 紀念版兼任建置能力、且不再需要將 macOS 13.3 SDK 與 LibArcLite 塞入 Xcode 15（會破壞其簽名），於是唯音輸入法 Aqua 紀念版專用倉庫的更新止步於 v4.8.0 版。今後與 Aqua 紀念版有關的發行版下載頁面會被併入到主流發行版的下載頁面。
- 研發：[所有發行版] 唯音輸入法從這一版開始在 Intel Mac 電腦上不再支援 Xcode GUI 編譯（Xcode 14 除外，只是需要手動指向 Swift 5.10.1 開源編譯套件），因為所有的 Intel Mac 均不支援 Xcode 27+、且唯音輸入法從這一版開始要求 Swift 版本「要麼是 5.10.1 開源編譯套件、要麼是至少 Swift 6.4 版開源編譯套件」。主倉庫有準備好一些 Makefile 指令，供有經驗的開發者滿足自行編譯之方便。
- 研發：[所有發行版] 唯音輸入法正式啟用 2025 年初開始籌備的先鋒引擎套件。這是一套引擎的總成，包括齊鐵恨注拼引擎、護摩組句引擎、整個打字態械等子引擎，這些聚合物可跨作業系統建置、在 Linux 與 Windows NT 系統下使用。除了 Aqua 紀念版因為 macOS 10.9 相容性需要之現狀、而對先鋒引擎採靜態鏈接處理以外，主流發行版的唯音輸入法對先鋒引擎採動態鏈接。唯音輸入法亦從這一版開始更換了授權：先鋒引擎套件採 LGPLv3 協議釋出，其餘部分採 MulanPSLv2 協議釋出。MulanPSLv2 協議類似於 Apache 2.0，相比而言省去了一些繁文縟節層面的義務。
- 研發：[所有發行版] 先鋒引擎專案 `vChewing-LibVanguard` 正式棄用 Plist 格式與 SQLite 格式的原廠 Trie 辭典格式支援。`vChewing-VanguardLexicon` 倉庫的辭典構築程式也移除了對這兩類原廠辭典格式的建構支援。
- 研發：[所有發行版] 先鋒引擎專案擁有了解讀 FCITX 按鍵事件 KeyCode 的能力。該能力留待今後的其他可能用途。
- 研發：[所有發行版] App Bundle 格式的安裝包移除了[十幾年前 Rogue Amoeba 所主張的 Sandbox Translocation 應對策略](https://weblog.rogueamoeba.com/2016/06/29/sierra-and-gatekeeper-path-randomization/)。唯音輸入法以 zip(app bundle) 與 pkg 格式分發的安裝包在設計上而言不會受此問題之困擾。
- 辭典：[所有發行版] 例行語彙資料更新。

#### 關於 Apple Developer 公證 & 安裝包 SHA256：

- 本次提供的安裝檔案均已做公證處理。
- 如果遇到 pkg 安裝包故障的話，請嘗試以「-alternative.zip」結尾的安裝程式。

[macOS 12+] vChewing-macOS-4.8.0-signed-alternative.zip (個人用戶推薦使用該安裝包)
230615d7562549b0837255a0f9b83f11121d3427335ab9baef6cfd9b316954f9

[macOS 12+] vChewing-macOS-4.8.0-signed.pkg (僅建議 Homebrew 或企業電腦藉由終端機批次部署時使用，部署時請勿使用管理員權限)
ce163f7d4102817b0651886336b4df5ce6b57fc8df2afffaa78e0be0e6008a1c

[macOS 10.09 ~ 12.x 專用] vChewingAqua-4.8.0-signed.zip
ecd7699c587d23d8bbdb6262bf5b1dfc91be21bcbf5d65e25fa2221b87641dd0
