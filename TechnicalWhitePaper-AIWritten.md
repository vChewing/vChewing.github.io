---
sort: 2
---
# 技術白皮書-機器稿 (v4.0.0)

# 威注音 v4.0.0 與小麥注音 v2.9.3：技術白皮書（重構版）

> 資料截取日期：2025-10-04。除非另行註明，以下內容係依本倉庫與 `mcbopomofo`、`vChewing-macOS` 專案主分支（main）當日狀態整理。

## 摘要

- **架構重寫幅度顯著不同**：威注音自 2022 年起以 Swift 為主體重構輸入調度、組字引擎、候選窗與安全模組；小麥注音延續 Objective-C++ / C++ 基建並聚焦效能與穩定維護。
- **安全模型差異鮮明**：威注音以 macOS Sandbox、浮動組字窗強化模式與可選客體清單阻絕 markedText 洩露；小麥注音保留腳本掛鉤與無沙箱設計，提供高度開放但安全自負的體驗。
- **語言模組策略分歧**：小麥注音採 Formosa::Gramambular2（DAG-Relax）搭配 OVMandarin MK2；威注音自研 Megrez（第四代最佳化 Dijkstra、第五代 DAG-DP），針對就地加詞、UTF-8 游標與自訂權重做最佳化。
- **候選窗與 UX**：威注音第三代田所選字窗採前後端分離、支援橫/縱排矩陣與 Unicode 資訊；小麥注音維持 Voltaire MK2 + VoiceOver 支援並提供熱鍵升頻介面。
- **多排列與拼音支援**：Tekkon 引擎提供九種注音排列與六種拼音系統並可同時顯示拼音，遠超 OVMandarin 的固定排列設計。

## 歷程年表與版本世代

威注音的開工點位於 `vChewing-macOS-AncientArchive` 倉庫提交 `5e0978b`，首個公開版 1.2.0 對應 `4083f18`。下表將 1.2.0 至 4.0.0 的重點演進濃縮成可引用的章節索引，便於在白皮書各處敘述時指涉具體世代。

| 時間段 / 版本 | 主要節點（含提交參考） | 關鍵成果與影響 |
| -- | -- | -- |
| **起始重構期**<br>(2021 Q4～2022 Q1)<br>1.2.0 `4083f18` 至 1.3.x `1e7459a`～`e39384c` | 從小麥注音 2022 年初狀態 fork；Swift 重寫計畫啟動。 | 逐步淘汰 ObjC++，建立 Swift 版本的輸入調度、組字雛型。|
| **Swift 化深化期**<br>1.4.x `04d4c60`～1.5.x `07a6a51` | Tekkon 並擊原型、Megrez 初版（沿用 DAG-Relax）、通知飄窗第一輪改寫。 | 注音排列擴充，CapsLock/Shift 模式控制雛形；浮動組字窗概念成形。|
| **安全與 UI 鞏固**<br>1.6.x `96453d0`～1.9.x `345c03d` | 浮動組字窗原型、就地加詞重寫、通知飄窗第二版。 | 奠定強化型組字區思路，調整候選窗與偏好設定架構。|
| **Megrez 第二代落地**<br>2.0.0 `5327825` | Swift 版本 Megrez 正式成為主力組字引擎，CandidatePool 雛型完成。 | Swift 模組化里程碑，為後續獨立 Package 化奠基。|
| **模組拆分與安全化**<br>2.3.x～2.5.x | `KBEvent` 前身引入、FolderMonitor 由 FSEventStream 改寫、工具提示改 NSAttributedTextView。 | 夯實輸入訊號管線；就地增刪詞流程與縱排提示初具規模。|
| **浮動組字窗安全模式**<br>2.6.x | 2.6.0～2.6.2 | SandBox 策略整理、客體黑名單機制，SecureEventInput 偵測雛形。|
| **Swift Package 化**<br>2.7.x | 2.7.5 | 通知飄窗第三版、模組全面拆包、IMK 選字窗封裝。|
| **田所選字窗世代交替**<br>2.8.0～2.8.9 | SwiftUI 田所初版→CoreGraphics 第三代；磁帶模式（CIN2）首發。 | 前後端分離 CandidatePool 成熟，橫/縱矩陣顯示、Electron App（EApp）相容策略萌芽。|
| **CIN2 磁帶與字根反查**<br>2.9.0～2.9.8 | 2.9.3 SP2、2.9.5 SP2、2.9.8 | 簡碼選字、字根反查、就地增刪詞即時生效；使用者詞庫整理器優化。|
| **語彙編輯器雙平台**<br>3.0.0 系列 | 3.0.0 SP3 | SwiftUI / Cocoa 語彙編輯器並存，MainAssembly Package 化，單元測試回歸。|
| **InputToken 與多輸出**<br>3.1.x～3.3.x | 3.1.0 SP1、3.3.0 | 注音反查、Ruby/INMU/盲文鋪墊、InputToken 巨集系統。|
| **資料格式演進**<br>3.4.x | 3.4.0～3.4.9 | 組字區即時預覽、原廠辭典 JSON 化、Tekkon 防呆。|
| **田所第三代與安全巡檢**<br>3.5.x～3.6.x | 3.5.3、3.6.2、3.6.3 | CoreGraphics 田所第三代、SQLite 辭典、偏好設定備份、SecureEventInput 警示。|
| **KBEvent 與游標操作**<br>3.7.x | 3.7.0～3.7.4 | KBEvent Struct 正式上線、Alt 游標移動、InputToken 擴展。|
| **CandidatePool 服務化**<br>3.8.x | 3.8.1～3.8.6 | Unicode 資訊、服務選單、盲文輸出、JSON Dump、Electron App 自動浮窗、Swift Concurrency 全面導入。|
| **Megrez 第四代**<br>3.9.0～3.9.2 | 3.9.0（`Dijkstra`）、3.9.2（POM 修訂） | 採最佳化 Dijkstra，並行輸入法控制元件重構、ChatGPT 黑名單。|
| **Megrez 第五代**<br>4.0.0 | DAG-DP、POM（野獸常數）、FolderMonitor Actor+Debounce、Sandbox 整併 | 去除上游半衰模組依賴，安全機制統合，田所選字窗玻璃特效自適應。|

> 註：表中提交號僅列核心節點；1.3.x～1.9.x 完整 commit 清單請參考 AncientArchive (`1e7459a`~`345c03d`)，2.6.2 以後則可在主倉 `vChewing-macOS` 以 tag 對照。

以下里程碑以 `git tag --sort=creatordate` 與關鍵提交為依據，並可對照官方發佈頁：
- McBopomofo Releases：<https://github.com/openvanilla/McBopomofo/releases>
- vChewing Releases：<https://github.com/vChewing/vChewing-macOS/releases>

### 小麥注音（標籤摘錄）

- **2024-10-21 — 2.8**：詞庫補強（行政區／教育部辭典對齊）、點字數字轉換修正、可關閉錯誤蜂鳴、保留傳統注音自訂字庫、最低系統需求調整為 macOS 10.15（標籤訊息）。
- **2025-02-10 — 2.9.0**：詞庫增修、聯想詞強化（標籤訊息）。
- **2025-02-25 — 2.9.1**：修正連打一聲出現句號、偏好設定新增 Shift+Enter 聯想詞選項、加入漢語拼音輸出；詞庫更新（標籤訊息）。
- **2025-03-04 — 2.9.2**：修復 macOS 15.4 beta 安裝失敗（標籤訊息）。
- **2025-07-07 — 2.9.3**：新增重複標點循環、候選窗「+」「-」控頻、詞長上限調整為八字、詞庫更新（標籤訊息）。

### 威注音（標籤與關鍵提交）

> 2022 年度版本資料取自 `vChewing-macOS-AncientArchive` 的鏡像歷史；由於該倉庫未保留 Git tag 實體，故以「Bump version」提交與同日合併提交對應公開版本。

#### 2022 年初版（AncientArchive）

- **2022-01-01 — 開工提交 `5e0978b5`**：倉庫結構調整與子模組納入，作為 Swift 化前置作業。
- **2022-02-02 — 1.2.0 (`4083f189`)**：首個 1.x 版本（r893）發佈，完成移轉後的初始包裝。
- **2022-02-11 ～ 2022-03-18 — 1.3 系列 (`1e7459ae`～`b4f72943`)**：連續釋出 1.3.0～1.3.9b，逐步修復候選與資料（含 1.3.7 OSR2 `54e853c2`、OSR3 `89f54cb6`）。
- **2022-03-19 ～ 2022-04-06 — 1.4 系列 (`04d4c606`～`dcc2f7ee`)**：1.4.0～1.4.7b 聚焦安裝相容性與候選窗修補，其中 1.4.5b `be22d913` 提供額外相容性修正。
- **2022-04-11 ～ 2022-05-18 — 1.5 系列 (`61d1e4ab`～`9a71d52e`)**：1.5.0 大量整併 Gitee PR；1.5.1 `a201ee4d` 開始 Swift 化 `KeyHandler`；1.5.4 `f43e3f59` 引入 Megrez；1.5.7 `0cde7469` 導入 Tekkon；1.5.9 `9a71d52e` 增補拼音輸入與資料更新。
- **2022-05-21 ～ 2022-06-09 — 1.6.0～1.7.0 SP2 (`96453d04`～`98b8e920`)**：強化熱鍵體驗、效能與多語支援，涵蓋 1.6.x、1.7.0 及其 SP 修正版。
- **2022-06-18 ～ 2022-06-27 — 1.7.1～1.7.3 (`cd8bcbd0`、`9acbdaeb`、`4bdb528f`)**：聚焦候選列表穩定性與 bug 修補，為後續 Swift 拆模鋪路。
- **2022-07-06 ～ 2022-07-08 — 1.7.4／1.7.4 SP2 (`433b3ea5`、`f0a33c08`)**：拆解 `ctlInputMethod`、移除 ObjC++ 橋接並加強組字調度偵測。

#### 2022 年下半年至 2025

- **2022-07-12 — 1.8.0（Build 1980／SP2）**：Tekkon v1.2.4／Megrez v1.2.8 導入（commits `1eae8198`、`4ff9051c`、`21e4aaff`），新增 Alt+方向鍵選字、候選高亮調整。
- **2022-07-18 ～ 2022-08-09 — 1.8.1～1.9.0 SP1 (`62e37af4`、`27b51ea8`、`509262bf`、`1962455e`、`5ba2d518`、`c68d7dd1`、`d5f0ed4b`、`c7f218ae`、`f7e703dc`)**：完善關聯詞、數字鍵盤支援、Starlight/Seigyou 排列、Shift/Alt 英數模式與救援修補。
- **2022-08-11 ～ 2022-08-17 — 1.9.1 SP2～1.9.4 (`a227fa84`、`71afd139`、`75e93d09`、`345c03db`)**：IMKCandidates 功能定型，包含聯想詞改進、Shift/候選視窗介面調整與上下文併句最佳化。
- **2022-08-20 — 2.0.0（Build 2000／SP1、SP2）**：IMKCandidates 候選窗首次啟用並快速迭代（commits `59df9a5f`, `53278250`, `2c52c41d`），引入客製字型與視窗層級調整。
- **2022-08-26 — 2.1.0（Build 2101）**：候選窗模組與 CheatSheet 文件模組化（commit `91b27c12`），配合 Swift Package 拆分與 Issue Template 建置。
- **2022-08-29 — 2.2.0（Build 2201）**：直書標點硬化、候選矩陣垂直排版調整以及 BookmarkManager／沙盒偏好整備（commits `83737af7`, `504a1d70`, `18596d52`）。
- **2022-08-31 — 2.3.0（Build 2300）**：啟用 Hardened Runtime、PKG 安裝流程重構（commit `1f0e58cf`），建立後續沙箱部署基線。
- **2022-09-01 — 2.3.1（Build 2310）**：Shift 鍵適應行為可調、InputSignal 改以協定驅動（commits `7054c4ea`, `c6f03b42`）。
- **2022-09-06 — 2.4.0（Build 2400／SP2）**：「去 Zonble 化」第一階段，InputState 換裝 Swift 架構、Emacs 快捷鍵重寫（commits `1b172e41`, `cd379b82`, `3f7d0d1b`）。
- **2022-09-09 — 2.5.0（Build 2500）**：PopupCompositionBuffer 與 TooltipUI Swift 套件化，DevZone 設定更新（commits `131eda08`, `59b0cc1c`, `2fe7123a`）。
- **2022-09-11 — 2.6.0（Build 2600／SP1-SP2）**：Steam 遊戲支援、直書組字窗調整、客體列表管理器導入（commits `1c43d6b3`, `19c9ee84`, `7d37a76e`）。
- **2022-09-15 — 2.6.2（Build 2620／SP1-SP3）**：沙箱修復、Tooltip 強制重建與 High Sierra 相容性調整（commits `be46d1bd`, `c7b6fd7a`, `0a1e855d`）。
- **2022-12-17 — 2.8.0**：多個 Swift 套件化模組（例：Tekkon、CandidateWindow、Shared）納入專案骨架（首次加入 commit `9d077a9d`、`030a8cb7` 等）。
- **2023-07-30 — commit `339cfb0a`**：田所選字窗核心改寫（AppKit + CoreGraphics 重繪，CandidatePool/CandidateCellData 重構），正式捨棄 SwiftUI 捲動實作。
- **2023-12-28 — 3.7.0**：年終穩定版標籤（針對 macOS 14.x 調整；詳細內容見發佈頁）。
- **2024-02-13 — 3.8.0／2024-02-17 — 3.8.1**：3.8 系列釋出；田所選字窗新增碼位資訊與反查刷新（commits `424a736c`, `b20dfec6`, `e887ba01`）。
- **2025-01-28 — 3.9.0**：海燈節版；Megrez 改以最佳化 Dijkstra 路徑（commit `1c3225d3`），為 4.0.0 DAG-DP 過渡階段。
- **2025-10-04 — 4.0.0**：Megrez `PathFinder` 採 DAG 動態規劃（`Packages/vChewing_Megrez/Sources/Megrez/2_PathFinder.swift`），FolderMonitor Actor 化與 Debounce 完成，直書提示方案改版；同日發佈 tag `4.0.0`。

## 背景與定位

### 專案角色速覽

| 專案 | 主要語言 | 核心維運者 | 目標系統 | 授權 | 定位 |
| -- | -- | -- | -- | -- | -- |
| 小麥注音 (McBopomofo) 2.9.3 | Objective-C++, C++17, Swift | OpenVanilla 核心團隊 | macOS 10.15+ | MIT | Formosa::Gramambular2／OVMandarin MK2 實作、強調穩健與開源協作 |
| 威注音 (vChewing) 4.0.0 | Swift 5.9+, 極少量 ObjC | Shiki Suen 等 | 主流版 macOS 13+；Aqua 紀念版支援 10.9 | MIT-NTL | Swift 原生化注音輸入法、專注安全與模組擴展 |

### 名詞釐清（摘要）

- **OpenVanilla 框架**：CIN 系統輸入法集合，現已不再綁定香草注音模組。
- **香草注音 (SpaceChewing)**：新酷音移植，不屬於小麥注音支線。
- **奇摩輸入法**：Zonble / Lukhnos 於商業案打造，奠定 OVMandarin + Gramambular 早期實作。
- **LibFormosa**：提供 OVMandarin MK1 與 Gramambular MK1 引擎，是小麥注音語言模組核心。但後來 OVMandarin MK2 與 Gramambular MK2 沒被繼續統稱為 LibFormosa。

## 架構剖析

### 模組對照（概要）

| 面向 | 小麥注音 2.9.3 | 威注音 4.0.0 | 來源參考 |
| -- | -- | -- | -- |
| 輸入訊號 | `KeyHandler` (Objective-C++) + `KeyHandlerInput` (Swift struct) | `InputHandler` (Swift) 直接擴展 `NSEvent` / `KBEvent` | `mcbopomofo/Source/KeyHandler.mm`；`vChewing_MainAssembly/InputHandler_Handle*.swift` |
| 態械 | `InputState` 類別階層（NSObject） | `IMEState` / `IMEStateData` 單一 struct + protocol | `mcbopomofo/Source/InputState.swift`；`vChewing_MainAssembly/IMEState.swift` |
| 組字引擎 | Gramambular 2 (C++, DAG-Relax) | Megrez (Swift, DAG-DP；3.9 系列曾採強化版 Dijkstra) | `mcbopomofo/Source/Engine/gramambular2`；`vChewing_Megrez` |
| 聲韻並擊 | OVMandarin MK2 (C++) | Tekkon (Swift) | `mcbopomofo/Source/Engine/mandarin`；`vChewing_Tekkon` |
| 候選窗 | Voltaire MK2 (Swift Cocoa)；VoiceOver 朗讀 | 田所選字窗第三代（Cocoa + CoreGraphics，自繪矩陣，前後端分離） | `mcbopomofo/Source/NonModalAlertWindowController.swift` 等；`vChewing_CandidateWindow` |
| 安全 | 無沙箱；允許就地腳本掛鉤 | macOS Sandbox、浮動組字窗強化模式、客體管理器白名單 | `mcbopomofo/add-phrase-hook.sh`；`vChewing_MainAssembly/InputHandler_HandleSecurity.swift` |
| 字典 | Parseless LM (TXT) + 使用者詞庫 TXT | SQLite 原廠詞庫 + 使用者 TXT，內建整理器 | `LanguageModelManager.mm`；`vChewing_LangModelAssembly` |
| 監控 | FSEventStream | DispatchSourceFileSystemObject + Actor + Debounce | `Packages/FSEventStreamHelper`；`DanielGalasko_FolderMonitor` 改造 |

### 輸入訊號管線

- **小麥注音**：`KeyHandlerInput` 將 `NSEvent` 轉換成內部 struct，`KeyHandler` 依狀態機驅動。Emacs key 等特殊鍵需逐層傳遞。
- **威注音**：直接對 `NSEvent` 擴展 `InputSignalProtocol`，並提供 `KBEvent` 克隆以 struct semantics 處理；在訊號入口即翻譯 Emacs 快捷鍵並塞入狀態資訊（例如直書模式）。

### 態械設計

- **小麥注音**：每種狀態為獨立子類別，依賴 `NSStringUtils` 處理 UTF-16 範圍；UI 資料（`NSAttributedString`）與狀態緊耦合。
- **威注音**：`IMEState` + `IMEStateData` 拆分資料與行為，預設以 UTF-8 游標記錄，僅在回傳 IMK 時投影到 UTF-16；就地加詞/刪詞/降頻、Tooltip 顏色與候選過濾皆以 value-type 快照儲存。

### 組字與語言模型

- **Gramambular 2**：採 DAG-Relax，與 OVMandarin MK2 成熟整合；增量輸入時需重新鬆弛圖邊。
- **Megrez**：三代演進後採 DAG-DP，自底向上計分，支援字詞/讀音長度不等、就地標記游標、JSON 行為分析；三代曾使用自訂優先佇列 Dijkstra 以優化長句效能。

### 聲韻並擊與拼音

- **OVMandarin MK2**：固定排列、專注傳統注音輸入。
- **Tekkon**：支援九種注音排列（含動態排列）與六種拼音系統，可於注音並擊時同步顯示拼音；對 JIS 小鍵盤與聲調鍵覆寫提供客製行為。

### 候選窗與 UI

- 小麥注音：Voltaire MK2 以 Cocoa 實作、支援 VoiceOver；自 2.9.3 起提供熱鍵升頻，但不支援矩陣佈局與 Unicode 詳情。
- 威注音：田所選字窗第三代使用 CandidatePool 前後端分離；支援橫/縱排矩陣顯示、Unicode 資訊、CIN 字根反查、右鍵控頻／刪詞、介面字型針對簡繁模式自動切換（需在開發道場啟用）。

### 安全與沙箱

- 小麥注音允許在 `defaults write` 後就地執行腳本；無沙箱束縛，FSEventStream 監控可能放大外部干預風險。
- 威注音使用 Sandbox Profile 限制檔案與進程互動，浮動組字窗可針對特定客體 App 為組字區加殼，防止 `markedText` 被探知；新增 FolderMonitor Actor 化並加入 Debounce，降低 iCloud 同步抖動造成的 Hang 風險。

## 功能矩陣（節選）

| 功能 | 小麥注音 2.9.3 | 威注音 4.0.0 | 備註 |
| -- | -- | -- | -- |
| 注音排列 | 大千傳統、倚天傳統、IBM、許氏、倚天 26 | 上述＋神通、(偽)精業、酷音大千 26、星光、劉氏 | 威注音動態排列可因模式調整鍵位 |
| 拼音 | 單一拼音模式（未提供文件） | 漢語、國音二式、華羅、耶魯、通用、韋氏；並擊提示拼音 | 
| CIN 表格 | ✖️ | ✅（磁帶模式支援 CIN2） | 
| Emoji 組態 | 原廠 Emoji，無獨立詞頻 | 專屬使用者 Emoji 辭典 + 開關 | 
| 就地加詞/刪詞/控頻 | 只支援加詞 | 加詞、刪詞、升降頻（Shift+Command+Enter 降頻） | 支援詞音不等長 |
| CapsLock 強制英文忽略 | ✖️ | ✅ | 顧及微軟新注音習慣 |
| 候選矩陣 | ✖️ | ✅ 橫/縱排矩陣（田所） | 
| Unicode 資訊 | ✖️ | ✅（田所） | 
| VoiceOver | ✅（2.9.3 後） | ➖（規劃重做） | 威注音採自繪矩陣，尚未加入 AX 子樹 |
| 熱鍵輪替候選 | Shift(+Alt)+Space、Alt+↑/↓ 等 | Shift(+Alt)+Space、Alt+↑/↓（橫）／Alt+←/→（縱） | 威注音納入直書焦點鞏固 |
| Alt 熱鍵佈局切換 | ✅（終端設定） | ✖️（避免 NSMenu 攔截） | 
| 漢音符號 | 部分符號 | 完整漢音符號＋分層符號表（可自訂 `symbols.dat`） | 
| 簡繁支援 | 轉換（OpenCC / VXHanConvert） | 原生繁/簡詞庫 + Hotenka 詞組轉換 + JIS/康熙選項 | 威注音就地加詞跨模式同步 |
| W3C Ruby | Linux 版支援注音，mac 版無 | 支援注音（教科書式）、漢語拼音 Ruby | 
| 日期巨集 | ✅ | ✅（並新增銀行大寫數字等） | 

## 字典與資料管理

- **小麥注音**：Parseless LM 以 TXT 表格儲存，FSEventStream 監控使用者詞庫；就地加詞時執行 `EOF` 修復與可選腳本。
- **威注音**：原廠詞庫採 SQLite，使用者詞庫仍以 TXT 儲存但由內建整理器重整；學習權重資料以 JSON 保存，可於偏好設定清除；FolderMonitor 透過 Actor + 去抖動防止高頻事件連鎖。

## 安全與隱私對照

| 項目 | 小麥注音 | 威注音 |
| -- | -- | -- |
| 沙箱 | ✖️ | ✅ （限制檔案/進程存取） |
| 浮動組字窗 | ✖️ | ✅（強化模式，可針對客體 App 指定） |
| 網路連線 | 自動檢查更新（預設啟用） | 手動啟用檢查更新 |
| 就地腳本 | ✅（可在 defaults 中設定） | ✖️（禁止執行） |
| 資料上傳 | 無 | 無（沙箱防護） |

典型風險與緩解：威注音以浮動組字窗阻斷 markedText 被輪詢、SandBox 避免腳本濫用；仍無法抵禦系統層級鍵盤側錄。小麥注音提供彈性但須使用者自律，腳本掛鉤若被濫用可能造成資料外洩。

## 無障礙與國際化

- 小麥注音於 Voltaire MK2 中為候選項建立 `NSAccessibilityElement`，在 VoiceOver 下可被朗讀，但僅支援橫排選字。
- 威注音使用自繪矩陣；未來規畫以 proxy element 實作 `AXChildren` 與 `AXSelectedChildren`，同時保留 macOS 10.9 回溯相容。
- 介面語言：小麥注音提供繁中與英文；威注音支援繁中、簡中、日文、英文。

## 效能觀測（vChewing 4.0.0 實測）

量測環境：macOS 14.0 (arm64e)、Apple Swift 5.10 toolchain。

| 指標 | 測試方法 | 結果 |
| -- | -- | -- |
| 候選生成平均延遲 | `swift test --skip-build --filter MegrezTestsAdvanced/test08` | 約 5 ms |
| DAG-DP 長句評分 | `test09_Compositor_StressBench` | 0.0030 s（建圖耗時 24.6 s） |
| 記憶體峰值 | `/usr/bin/time -l swift test --skip-build --filter …test09…` | 117 MiB RSS |
| 學習權重寫入 | `test10` | 0.010 s / 52.7 MiB RSS |
| FolderMonitor 去抖動 | 360 原始事件 → 1 回呼 | 99.7% 抑制 |

（小麥注音官方未提供對等測試指標。）

## 維運與生態

- 威注音拆分 20+ Swift Packages（Tekkon、Megrez、CandidateWindow、TooltipUI 等），利於跨平台或未來延伸；同時保留 Aqua 紀念版支援舊系統（Swift 5.9 上限）。
- 小麥注音維持 Xcode 專案一體化，著重 Stability；語言模型沿用 LibFormosa 生態，便於與其它 OpenVanilla 模組共用資源。
- vChewing integrate `HangarRash_SwiftyCapsLockToggler`, `Qwertyyb_ShiftKeyUpChecker` 等外部套件以強化體驗；相對地 mcbopomofo 使用 `NSStringUtils`、`FSEventStreamHelper` 等傳統依賴。

## 既知限制與後續規劃（摘錄）

- **VoiceOver**：威注音田所選字窗尚未完成 AX 子樹；計畫採 NSAccessibilityCustomRotor / Proxy 元件。
- **大篇幅簡繁轉換**：Hotenka 著重詞組級互換，不適合批次文件；建議使用外部工具。
- **Emacs 鍵支援範圍**：威注音現支援 Ctrl+N / Ctrl+P 等常用移動鍵；其它（如 Ctrl+K）仍在評估。
- **SwiftUI 選字窗**：因效能犧牲已退場；待 SwiftUI 繪製效率提升再評估混合方案。
- **SandBox 限制**：無法防範使用者允許的系統層錄音工具。

## 參考原始碼位置

- 小麥注音：`mcbopomofo/Source/Engine/gramambular2/`、`mcbopomofo/Source/Engine/mandarin/`、`mcbopomofo/Source/InputState.swift`、`mcbopomofo/Source/KeyHandler.mm`。
- 威注音：`vChewing-macOS/Packages/vChewing_Megrez/`、`vChewing-macOS/Packages/vChewing_Tekkon/`、`vChewing-macOS/Packages/vChewing_MainAssembly/`、`vChewing-macOS/Packages/vChewing_CandidateWindow/`。

## 建議引用格式

- APA：vChewing 專案團隊（2024）。《威注音輸入法技術白皮書（重構版）》版本 4.0.0。取自 https://vchewing.github.io/TechnicalWhitepaper-rewritten
- MLA：vChewing Project Team. *vChewing Input Method Technical Whitepaper (Rewritten)*. Version 4.0.0, 2024. Web. https://vchewing.github.io/TechnicalWhitepaper-rewritten
- Chicago：vChewing Project Team. 2024. *vChewing Input Method Technical Whitepaper (Rewritten)*. Version 4.0.0. Accessed YYYY-MM-DD. https://vchewing.github.io/TechnicalWhitepaper-rewritten

## 版本註記

- 本白皮書為 `TechnicalWhitePaper.md` 的重構版，以資訊架構重整、聚焦關鍵差異與安全模型。原始文檔保留作為歷史背景與細部敘述參考。
