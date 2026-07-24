> **唯音輸入法專案目前正式接收贊助**，將會用於該輸入法的年度維護更新。
> 贊助渠道：[Patreon](https://www.patreon.com/c/shikisuen/membership) 。
> 微信使用者與支付寶使用者可以電郵給開發者以詢問其他可行的渠道。
> 這些費用會用於 Apple 開發者會員年費、以及其他與軟體開發有關的支出。
> 請注意 **所有的贊助金只會被當作餽贈，且不會對在下施加任何義務與合約**。感謝您的理解。
> 如果您有配樂製作或流行歌曲弦樂編曲的需求的話、或者管弦樂錄音樂譜製作需求的話，
> 也歡迎外包給唯音輸入法的開發者，這是他希望能接到的主要業務。
> 開發者目前最需要的主要業務是配樂相關的客戶資源，期待能與您合作。

#### 4.5.6 版針對 4.5.5 版更新了下述內容：

- 研發：[所有發行版] 重構了該輸入法的打字會話副本管理邏輯暨其與 InputMethodKit 的交互邏輯：
    - 前置說明：在前一次更新停用 ObjC-ARC 之後的使用過程中，開發者注意到了一些與記憶體利用效率有關的異常狀況，才決定實施這次重構。本次重構亦將 IMKInputController 的整個生命週期管理徹底逐出 Swift ARC 的可觸及範圍：所有 controller 實例的 alloc / dealloc / retain / release 均在 ObjC MRC 層完成，Swift 端僅透過 raw 記憶體位址與之互動，不再有任何 Swift ARC 參考計數操作牽涉其中。
    - 現狀調查結果：藉由對 InputMethodKit（10.9 Mavericks 至 10.15 Catalina，以及 macOS 27 GoldenGate）的逆向工程調查，開發者發現 IMKServer 內部存有下述缺陷：
        - IMKServer 內部以 `_private._controllers`（NSMutableDictionary）管理所有 IMKInputController 實例。該 dictionary 的 key 是 `[NSNumber numberWithUnsignedLong:clientProxyAddr]`——即每次 init 時傳入的 client proxy 物件的記憶體位址。
        - 每次 CapsLock 切換中英輸入法時，IMKServer 都會為同一個 App 建立**全新的** DO/XPC proxy 物件，其記憶體位址與上一次不同。這使得舊 controller 的 dictionary key 永遠無法再被 lookup 命中——IMKServer 原廠的 controller 複用邏輯因此對 CpLk 切換場景完全失效。
        - 雖然 IMKServer 提供了 `sessionFinished:` 方法來清理某個 App 堆積的 IMKInputController，但 `sessionFinished:` 是 per-client-proxy 的通知：舊 proxy 在 CpLk 切換後已被新 proxy 取代，IMKServer 不再為舊 proxy 派送任何訊息，自然永遠不會觸發 `sessionFinished:`。結果就是每次「CpLk 中英輸入法切換」都產生一個**永不被清理的孤棄 controller**。
        - 孤棄 controller 所持有的 client wrapper（macOS ≤10.15 為 `IPMDServerClientWrapper`；macOS 15 Sequoia 起將此拆分為 `_IPMDServerClientWrapperModern` 與 `_IPMDServerClientWrapperLegacy`）包含 `_xpcConnection`（NSXPCConnection）或 `_clientDOProxy`——這些連線資源同樣永遠不會被釋放。IMK 內部透過全域快取管理這些 wrapper，必須透過 `+terminateForClientXPCConn:` / `+terminateForClientDOProxy:` 等 private class method 才能將其移除。
        - 上述問題在 ARC 模式下或可被 autoreleasepool 間接緩解，但 retain/release 的高頻開銷會在某些電腦上導致 CapsLock 切換時的明顯卡頓。停用 ARC 改用 MRC 後，卡頓問題消失，但必須自行處理孤棄 controller 與殘留 XPC 連線的清理。
    - 針對上述缺陷，唯音輸入法 4.5.6 版實裝了下述修復機制：
        - **Controller 世代戳記與主動清理**：每個 IMKInputSessionController 在 init 時被分配一個單調遞增的 generation number。當 `_controllers` 內的 controller 數量超過 2 時，自動找出 generation 最舊的非活躍 controller，透過 KVC 從 `_private._controllers` 中移除（`removeObjectForKey:`），使其在 MRC 下被正常釋放。
        - **極性雙緩衝 Session 池**：利用 generation number 的奇偶性（parity），將所有 controller 對映至兩枚 static InputSession singleton（偶數→session A，奇數→session B）。每次 CpLk toggle 後的新 controller 自動對接到**另一個** session，上一個 session 則保留不釋放，等待下一個同極性 controller 接手。此舉完全消除了 InputSession 的動態分配與 LRU 淘汰邏輯。
        - **XPC 連線清理**：在 controller 的延遲釋放階段（`deactivateServer:` 後 3 秒），主動呼叫 client wrapper 的 `terminateForClient*` private class method，將殘留的 wrapper 從 IMK 內部快取中移除、釋放其持有的 NSXPCConnection。因應 macOS 15 Sequoia 起將 wrapper 類別拆分為 `_IPMDServerClientWrapperModern` / `_IPMDServerClientWrapperLegacy`，程式以 `respondsToSelector:` 依序嘗試兩者，再 fallback 至舊類別名稱以向前相容。
        - **延遲釋放機制**：controller 在 `deactivateServer:` 後不會立即釋放，而是排程 3 秒後執行清理（釋放 blocks、終止 client wrapper、清理 controller↔session 對照表）。若 3 秒內 controller 被重新啟用（`activateServer:`），則取消排程、恢復正常服務。此設計確保了 CpLk 快速切換時不會出現「舊 controller 已死、新 controller 尚未就緒」的真空期。
        - **Dangling pointer 防護**：在所有以 `takeUnretainedValue()` 解讀 raw 記憶體位址的路徑上追加了保險機制——`IMKControllerLifetimeTracker` 在每次解讀前複查 controller 是否仍存活；`unregisterSessionAddr` 僅在 session 仍歸屬於該 controller 時才清空 `inputControllerAssignedAddr`（防止已 reassign 給新 controller 的 session 被舊 controller 的延遲 dealloc 誤清）；`reassign` 同步清除舊 controller 在 `sessionAddrByControllerAddr` 中的殘留 mapping。
    - **IME 選單注入機制**：`IMEMenuSputnik` 利用 ObjC Runtime 的 `class_addMethod` + `imp_implementationWithBlock` 將 Swift closure 直接註冊為 `IMKInputSessionController` 的 method IMP，無需透過 `@objc` Selector 暴露即可動態構建輸入法選單。選單內注入兩項即時監測資料：(1) `IMKControllerLifetimeTracker` 所追蹤的 controller 存活副本數量；(2) 以 `task_vm_info.internal` 取得的 anonymous private memory 用量。為確保記憶體讀數真實反映釋放狀況，每次選單開啟前會先呼叫 `purgeMallocZones()` 強制回收 allocator cache。
- 辭典：[所有發行版] 例行語彙資料更新。

<details>
<summary>已知問題（請點擊這一行文字以展開閱讀）。</summary>

1. Naver Line 聊天軟體對 IMKTextInput 內文組字區的實作有問題（根本看不到組字區下劃線當中的特殊 Marking 區段標記），所以被唯音預設放在客體管理器黑名單內。副作用就是一定會出現浮動組字窗，請諒解。如果您一定想要在 Line 軟體內使用內文組字區的話，請藉由客體管理器自行取消對 Naver Line 的勾選，相關後果自負（因為一切責任都在 Naver Line 的開發團隊）。
2. 沙箱特性帶來的些許不便。請參見 2.3.0 版的更新日誌。引入沙箱是為了打消一些使用者們可能抱持的資安疑慮，但使用者仍可自行使用 HIPS 類工具軟體來主動監督唯音輸入法的軟體行為。
3. 有些使用者經常遇到與 SecureEventInput 有關的濫用警告。唯音不替任何濫用 SecureEventInput 的軟體開發者們負責。受不了相關警告的話，雖然您也可以藉由輸入法偏好設定畫面的開發道場頁面來關掉相關偵測功能，但您也還可以將這類軟體檢舉給 Apple Support，因為他們對 SecureEventInput 的濫用行為禍害了系統內所有的第三方輸入法軟體的正常運作。
4. 如果您在使用 macOS 14 Sonoma 及之後的版本的系統的話，請勿使用唯音 3.5.3 及之前的版本，因為這些版本可能會觸發系統內的某些缺陷、導致整個系統畫面失去響應。此外，如果您有將使用者片語辭典目錄放在任何網路硬碟的話，請勿使用唯音 4.3.6 及之前的版本，否則可能會在這些網路硬碟因為 DNS 故障陷入同步失敗的過程時出現「輸入法卡死整個系統」的情況。
5. 強烈建議您將您在用的任何終端機軟體都拽入唯音輸入法的客體管理器（且打勾），因為幾乎所有的副廠終端機軟體的開發者們在技術上都沒有任何動力去將內文組字區的體驗做得像 macOS 內建終端機那樣完美。
6. 請勿在諸如 NSMenu 以及 Spotlight 這種浮動窗內使用田所選字窗的滑鼠右鍵選單，否則可能會遇到「選字窗消失，只剩下滑鼠右鍵選單」的情況。此時需要切換到別的 App 再切換回來、才可以正常敲字。該故障目前無解。因此，唯音自 3.1.0 版開始對 Spotlight 和 Raycast 這兩個客體應用停用田所選字窗滑鼠右鍵選單。
7. 唯音輸入法本身很多與 Enter 鍵有關的組合鍵在微信等少數應用當中無法生效，因為這些客體應用在訊息窗格內輸入文字時始終會攔截 Enter 鍵的訊號處理、而無視 InputMethodKit 組字區內容的有無。如有相關需求者，可以先行用其它文字編輯軟體敲好訊息之後、藉由剪貼簿中轉、再貼入這類客體應用當中。
8. 田所選字窗不支援滾動條捲動，但理論上應該不會影響使用。
9. 出於諸多原因，macOS 系統內建的 IMK 選字窗支援截止於 3.5.3 版、之後不再提供相關支援。一款連 Apple 自己都不想做好的系統元件，第三方開發者拿來用的話，這維護成本實在是過於空前。
10. 唯音輸入法的 INMU 格式遞交功能無法直接作用於 Sibelius / Dorico 這一類譜務工作站，而是先在其它文字處理軟體內準備好相關格式之後再利用給譜務工作站軟體。以 Sibelius / Dorico 2 為例的話，就是將這種格式的文字整段複製到剪貼簿內，然後在軟體的歌詞輸入模式當中連續 Command+V 貼上即可。Dorico 3 開始要麻煩一些，得事先在樂譜當中每個音符下插入一個字母，然後將這些音符全部選中、整段編輯歌詞，此時再將 INMU 格式的文本用 Command+V 整段貼上。詳見：https://forums.steinberg.net/t/150448
</details>

------

系統版本要求：至少 macOS 12 Monterey。請在安裝之前務必閱讀這篇《[安裝指引](https://gitee.com/vchewing/vChewing-macOS/wikis/%E8%AA%AA%E6%98%8E%E6%89%8B%E5%86%8A/%E5%AE%89%E8%A3%9D%E6%8C%87%E5%BC%95)》。因應不可控之技術現狀，今後請各位優先 [藉由 Gitee 下載](https://gitee.com/vchewing/vChewing-macOS/releases/)。如需要在更舊版的系統下運行的話，請前往[唯音輸入法主頁](https://vchewing.github.io/README.html)下載 Aqua 紀念版唯音輸入法，可支援自 macOS 10.9 開始至 macOS 12 Monterey 為止的系統版本。

<details>
<summary>其它注意事項（請點擊這一行文字以展開閱讀）。</summary>

> ⚠️ 注意：使用者們可以克隆「[libvChewing-data](https://gitee.com/vChewing/libvchewing-data)」且自行 `make install` 來手動安裝今後被官方更新過的最新核心辭庫。

> ⚠️ 警告：如果您硬碟內既存的唯音版本小於 2.3.0 ，則請在安裝此更新之前務必事先備份使用者片語辭典目錄的內容、然後在升級之後在輸入法偏好設定內重新設定一遍使用者片語辭典目錄。自唯音 2.3.0 版開始，唯音引入沙箱機制，使用者片語辭典目錄只能存放於「/Users/您的使用者帳戶名稱/」目錄下（也就是您的 Home 目錄）。
</details>

#### 關於 Apple Developer 公證 & 安裝包 SHA256：

- 本次提供的安裝檔案均已做公證處理。
- 如果遇到 pkg 安裝包故障的話，請嘗試以「-alternative.zip」結尾的安裝程式。

vChewing-macOS-4.5.6-signed-alternative.zip (個人用戶推薦使用該安裝包)
64f2b11230af1420c71289950cfb24ff13d1ee368296f0a42a82cb84a2053007

vChewing-macOS-4.5.6-signed.pkg (僅建議 Homebrew 或企業電腦藉由終端機批次部署時使用，部署時請勿使用管理員權限)
d229e2bdbc6099078fff5f957bc12e1b4c14f92092d83a72256bbe868a0a7cb9

vChewingAqua-4.5.6-signed.zip (macOS 10.09 ~ 12.x 專用)
03275fb268f5d6be4b1a4a0f7f2b027273ce18d7067f32b14fb713789425455d
