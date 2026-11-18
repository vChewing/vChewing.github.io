> ☕️ **唯音輸入法專案目前[正在接收贊助](https://vchewing.github.io/SPONSOR_ME.html)**，將用於年度維護更新、Apple 開發者年費等開銷。
>
> 請務必閱讀《[新手上路](https://vchewing.github.io/onboarding/)》與《[FAQ](https://vchewing.github.io/faq/)》，這便於您將唯音輸入法迅速配置成您想要的樣子。您也可以將這些鏈接丟給各種互動式 AI 服務來幫您解讀。

#### 5.0.4 版針對 5.0.3 版更新了下述內容：

- 懶人包總結：停用了 macOS 26 系統下的 SwiftUI 與 LiquidGlass；在偵測到 SecureEventInput (SEI) 濫用情形時不再嘗試關閉 SEI；偵錯日誌訊息現改用非同步推播處理。
- 行為：[所有發行版] 從這一版開始，敝輸入法對 macOS 26 停用 LiquidGlass 與「SwiftUI 版偏好設定視窗」。此乃因應 macOS 26.x 系統軟體整體品質劣退、導致 macOS 26.x 晚期版本 SwiftUI 行為怪異之現狀、而做出的忍無可忍的決定。macOS 26.x 系統所見到的唯音輸入法偏好設定畫面將會與 macOS 10.9 ~ macOS 13.x 一致。此番變更並不影響 macOS 27.x 開始的系統下的輸入法 UI 行為。
- 行為：[所有發行版] 用以主動偵測「其他程式濫用 SecureEventInput 導致所有副廠輸入法罷工」的機制做了調整，不再主動先行嘗試關閉 SecureEventInput。此外，也修正了與此有關的警示視窗的一些 NSAlert API 用法。這或許可以提升唯音輸入法與 macOS 27.1+ 的相容性。
- 行為：[所有發行版] 唯音輸入法在偵錯模式下現在會使用非同步的方式向系統遞交偵錯日誌訊息。
- 辭典：[所有發行版] 先鋒語料庫移除了「將辭典資料建置成小麥注音輸入法原廠詞庫格式」的能力、也無法再搭配小麥注音 Linux 版使用（無論是小麥官方的 fcitx5 版還是 QBane 單獨維護的 IBus 版均不在支援範圍內）。需要建置成 TSV 格式的話，VCDataBuilder 現允許建置成 `textKVSTableCHS` / `textKVSTableCHT` 格式、會摻入 ngram 資料。直接將這種 TSV 產物補上小麥注音的原廠辭典檔案頭之後給小麥注音使用的話，反而可能會因為小麥注音無法正確處理這個格式的 ngram 資料、而出現無法預測的衍生問題。
- 辭典：[所有發行版] 例行語彙資料更新＆複元圖資料更新。

#### 關於 Apple Developer 公證 & 安裝包 SHA256：

- 本次提供的安裝檔案均已做公證處理。
- 如果遇到 pkg 安裝包故障的話，請嘗試以「-alternative.zip」結尾的安裝程式。

[macOS 12+] vChewing-macOS-5.0.4-signed-alternative.zip (個人用戶推薦使用該安裝包)
680cafd88a2f0bbdf785ebc7e296fc9f7c69a6a36072cd4d47de55b2a3510330

[macOS 12+] vChewing-macOS-5.0.4-signed.pkg (僅建議 Homebrew 或企業電腦藉由終端機批次部署時使用，部署時請勿使用管理員權限)
9cccd0a81a66efc69e8594de65422da0e1177dd12aff8e40b2a215167137f98d

[macOS 10.09 ~ 12.x 專用] vChewingAqua-5.0.4-signed.zip
c829788398869dfe763eccde2ed318fea2f3f4d00fc4054c590baa83e24f27c5
