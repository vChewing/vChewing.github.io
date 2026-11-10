> ☕️ **唯音輸入法專案目前[正在接收贊助](https://vchewing.github.io/SPONSOR_ME.html)**，將用於年度維護更新、Apple 開發者年費等開銷。
>
> 請務必閱讀《[新手上路](https://vchewing.github.io/onboarding/)》與《[FAQ](https://vchewing.github.io/faq/)》，這便於您將唯音輸入法迅速配置成您想要的樣子。您也可以將這些鏈接丟給各種互動式 AI 服務來幫您解讀。

#### 5.0.1 版針對 5.0.0 版更新了下述內容：

- 懶人包總結：重新設計了一套專門用來負責管理對使用者辭典檔案寫入任務的管理模組，確保其執行過程不會阻塞到 IMK 打字事件流程。
- 修復：[所有發行版] 重新設計了一套專門用來負責管理對使用者辭典檔案寫入任務的管理模組，確保其執行過程不會阻塞到 IMK 打字事件流程。這項改動用以緊急解決某些個別使用者可能遇到的「就地加詞或對某個候選詞控頻之後，輸入法與正在接收打字的軟體一同失去響應」的極端情形。這種極端情形的誘因往往可能發生於檔案系統端，但一款輸入法仍需改良設計、以免使用者受此情形所困。
- 辭典：[所有發行版] 例行語彙資料更新＆複元圖資料更新。

#### 關於 Apple Developer 公證 & 安裝包 SHA256：

- 本次提供的安裝檔案均已做公證處理。
- 如果遇到 pkg 安裝包故障的話，請嘗試以「-alternative.zip」結尾的安裝程式。

[macOS 12+] vChewing-macOS-5.0.1-signed-alternative.zip (個人用戶推薦使用該安裝包)
4917985cb6a9f29b8aacc5dee8d93bd5997a3e4c1e7ae76d58f66aab64be7738

[macOS 12+] vChewing-macOS-5.0.1-signed.pkg (僅建議 Homebrew 或企業電腦藉由終端機批次部署時使用，部署時請勿使用管理員權限)
f1da341ab36872631331c24e30e8bc8fffe4134c6f980f4d03421535fef410cb

[macOS 10.09 ~ 12.x 專用] vChewingAqua-5.0.1-signed.zip
f6fb67b55cfb43e60d468ceede61ddb95839686d0f6ca4bd882fbe0e0e10f84b
