---
sort: 9
---
# Homa vs. MegrezNT vs. Gramambular2 Whitepaper

## Executive Summary
Homa 是 vChewing 生態系的次世代 Swift 組字引擎，在 API 整合與輸入法場景支援度上大幅超越前一代的 MegrezNT（C#）實作，同時與第三方開源專案 Gramambular2（C++）在授權、設計目標與功能性上有明顯區隔。本白皮書：

- 彙整三個專案的公開 API、內部架構與測試覆蓋範圍。
- 明確列出 Homa 相對 MegrezNT 的新增對外 API 與功能，指出 C# 版本尚未覆蓋的差異。
- 對照 Homa 與 Gramambular2 的核心實作差異，提供未來因應抄襲疑慮時可引用的證據。

## 專案概觀

| 專案 | 語言／平台 | 授權 | 主要定位 |
|------|------------|------|-----------|
| **Homa** | Swift 5+，SwiftPM 模組化 | LGPL-3.0-or-later（含自訂例外） | 次世代輸入法組字引擎，提供游標、覆寫、輪替等上層整合 API |
| **MegrezNT** | .NET 6+（C#），NuGet 套件 | LGPL-3.0-or-later | 前一代輸入法組字引擎，提供核心 lattice 與候選覆寫能力 |
| **Gramambular2** | C++17，CMake | MIT | 通用 lattice／語詞分段引擎，重心在讀音插入與最短路徑運算 |

## Homa 公開 API 與能力摘要

- `Homa.Assembler` 建構子支援 `gramQuerier`、`gramAvailabilityChecker` 以及可選的 `BehaviorPerceptor`，同時保留 `Config` 深拷貝建構子。
- 公開屬性：`assembledSentence`、`keys`、`segments`、`cursor`、`marker`、`maxSegLength`、`length`、`isEmpty`、`actualKeys`、`copy`。
- 游標／節點操作：`insertKey`、`insertKeys`、`dropKey`、`clear`、`currentMarkedRange`、`isCursorCuttingChar`、`isCursorAtEdge`、`moveCursorStepwise`、`jumpCursorBySegment`、`assignNodes(updateExisting:)`。
- 候選操作：`fetchCandidates(filter:)`、`overrideCandidate`、`overrideCandidateLiteral`、`revolveCandidate`、`consolidateCandidateCursorContext`、`getLogicalCandidateCursorPosition`。
- 覆寫鏡像與診斷：`generateNodeOverrideStatusMirror`、`restoreNodeOverrideStatusFromMirror`、`dumpDOT(verticalGraph:)`、`assemble()`。
- `perceptor` 提供與最近 3 個 `GramInPath` 內容有關的節點覆寫前後狀態統計資料給外部學習模組，`FIUUID` 識別節點，GraphViz dump 支援 LR／TB 兩種方向。

## MegrezNT 公開 API 與能力摘要

- `Megrez.Compositor` 透過 `LangModelProtocol` 介面與語言模型互動，提供 `InsertKey`、`DropKey`、`JumpCursorBySegment`、`Update(updateExisting)`、`Clear` 等核心方法。
- 公開屬性：`Keys`、`Segments`、`Cursor`、`Marker`、`MaxSegLength`、`Length`、`IsEmpty`、`AssembledSentence`、`Separator`。
- 候選操作：`FetchCandidatesAt`、`OverrideCandidate`、`OverrideCandidateLiteral`、`CreateNodeOverrideStatusMirror`、`RestoreFromNodeOverrideStatusMirror`。
- 無游標輪替與上下文鞏固 API，診斷功能僅有橫向 `DumpDOT()`。

## Gramambular2 公開 API 與能力摘要

- `Formosa::Gramambular2::ReadingGrid` 接受 `LanguageModel`，提供 `insertReading`、`deleteReadingBeforeCursor`／`AfterCursor`、`setCursor`、`walk()`、`candidatesAt`、`overrideCandidate`。
- `Node` 僅含 `OverrideType`（`kNone`、`kOverrideValueWithHighScore`、`kOverrideValueWithScoreFromTopUnigram`）與 `kOverridingScore = 42` 常數，無節點鏡像或使用者學習回呼。
- `Span` 使用 `std::array` 管理節點；`ScoreRankedLanguageModel` 將語言模型回傳結果排序。
- 無游標／標記器概念，GraphViz dump 需自行實作，`walk()` 回傳 `WalkResult`（附計時與節點統計）。

## Homa 相較於 MegrezNT 的新增／缺失 API 對照
下表列出 Homa 已提供但 MegrezNT 尚未覆蓋的公開能力，可作為後續移植或功能評估依據：

| Homa API／功能 | Homa 位置 | MegrezNT 是否具備 | 說明 |
|----------------|-----------|--------------------|------|
| `insertKeys(_:)` | `Homa_Assembler.swift` | ✗ | MegrezNT 僅提供單鍵 `InsertKey`，Homa 支援批次插入與原子回復。 |
| `actualKeys` | `Homa_Assembler.swift` | ✗ | Homa 暴露組句結果對應的真實鍵序，利於部分匹配與 UI 顯示。 |
| `currentMarkedRange()` | `Homa_Assembler.swift` | ✗ | Swift 版提供標記範圍運算，C# 版需自行計算。 |
| `isCursorCuttingChar(isMarker:)` | `Homa_Assembler.swift` | ✗ | 用於偵測游標切割節點的情境，MegrezNT 無對應 API。 |
| `isCursorAtEdge(direction:isMarker:)` | `Homa_Assembler.swift` | ✗ | Swift 版封裝游標邊界判斷，C# 需外部計算。 |
| `moveCursorStepwise(to:isMarker:)` | `Homa_Assembler.swift` | ✗ | Homa 支援逐字游標移動並自動跳過斷字，MegrezNT 僅有幅節跳轉。 |
| `getLogicalCandidateCursorPosition(forCursor:isMarker:)` | `Homa_CandidateAPIs_Revolver.swift` | ✗ | 為前置／後置游標模式換算邏輯位置；C# 版缺少此封裝。 |
| `revolveCandidate(cursorType:counterClockwise:)` | `Homa_CandidateAPIs_Revolver.swift` | ✗ | Homa 內建候選輪替機制，MegrezNT 尚未提供。 |
| `consolidateCandidateCursorContext(for:cursorType:)` | `Homa_ConsolidatorAPIs.swift` | ✗ | Swift 版提供上下文鞏固 API，確保覆寫時不破壞臨近詞；C# 版無對應功能。 |
| `perceptor`／`BehaviorPerceptor` | `Homa_Assembler.swift` | ？ | Homa 可在覆寫後提供與最近 3 個 `GramInPath` 內容有關的節點覆寫前後狀態統計資料給外部學習模組，MegrezNT 5.x 開始引入該功能、但有一定限制。 |
| `dumpDOT(verticalGraph:)` | `Homa_Assembler.swift` | 部分 | C# 版僅有橫向輸出，Homa 支援 LR／TB 切換。 |
| `FIUUID` 節點識別 | `Homa_Node.swift` | ✗（使用 `Guid`） | Swift 版以自訂 UUID 精簡 Foundation 依賴。 |
| `assignNodes(updateExisting:)` 例外處理 | `Homa_Assembler.swift` | ✗（`Update` 不拋錯） | Homa 當無節點更新時拋出 `.noNodesAssigned`，MegrezNT 以 `int` 回傳數量。 |
| `Homa.Exception` 類別化錯誤枚舉 | `Homa_Exception.swift` | ✗ | Swift 版以型別化錯誤表示各種場景，C# 以 `bool` 為主。 |

> 其餘核心函式（例如 `insertKey`、`dropKey`、`jumpCursorBySegment`、`fetchCandidates`、`overrideCandidate`、`generateNodeOverrideStatusMirror`）兩者皆具備，但命名遵循各語言習慣。

## Homa 與 Gramambular2 差異重點

1. **設計與語言層級**：Homa 將輸入法游標、標記器、候選輪替、上下文鞏固納入核心 API；Gramambular2 僅提供 lattice 建構與覆寫，游標邏輯交由呼叫端自行維護。
2. **覆寫機制**：Homa 透過 `Homa.Node.OverrideType` 與鏡像 API 管理覆寫狀態，並可回報 `BehaviorPerceptor`；Gramambular2 僅提供高分值與 top unigram 兩種覆寫模式，無鏡像或學習回呼。
3. **資料識別**：Homa 使用自訂 `FIUUID`，MegrezNT 以 `Guid`，Gramambular2 無持久節點 ID，改以 lattice 位置辨識。
4. **候選篩選**：Homa 預設過濾跨游標候選（`CandidateFetchFilter`），Gramambular2 `candidatesAt()` 產出的結果需外部過濾。
5. **GraphViz 支援**：Homa 內建 LR／TB 選項；Gramambular2 僅在測試中印出計時資訊，GraphViz 需自行實作。
6. **語言模型依賴**：Homa 與 MegrezNT 支援 bigram provider；Gramambular2 的 `LanguageModel` 僅定義 unigram 介面，bigram 需外部擴充。
7. **授權與註解風格**：Homa／MegrezNT 為繁中文註解與 LGPL，Gramambular2 為英文註解與 MIT，顯示來源與設計風格迥異。

## 單元測試對照

| 專案 | 測試框架 | 測試覆蓋亮點 |
|------|-----------|----------------|
| **Homa** | Swift `Testing` | `HomaTests_Basic`（鍵入／刪除／游標）、`HomaTests_Advanced`（候選輪替、鞏固、部分匹配）、`HomaTests_NodeOverrideStatus`（鏡像）、`HomaTests_Performance`（長句壓力）。 |
| **MegrezNT** | NUnit | `MegrezTests`（基本行為）、`NodeOverrideStatusTests`（覆寫鏡像）、`SimpleLM` 驗證語料。缺少游標輪替／鞏固測試。 |
| **Gramambular2** | GoogleTest | `reading_grid_test.cpp` 覆蓋 Span 操作、覆寫 reset、分詞、壓力測試；無游標與鏡像相關案例。 |

## 結論

- **Homa 對 MegrezNT 的演進**：Swift 版本不僅復刻前代核心功能，更補足輸入法常見的游標微調、候選輪替、上下文鞏固與學習回呼等需求。MegrezNT 若要達到同等使用體驗，需補齊列出的缺失 API。
- **Homa 與 Gramambular2 的顯著差異**：兩者在語言、授權、API 命名、功能重點與測試策略皆迥異。Homa 更貼近實際輸入法產品需求；Gramambular2 則定位於通用 lattice。這些差異提供充分證據，證明 Homa 並非 Gramambular2 的衍生抄錄。
- **後續建議**：
  - 若需對外溝通，可將本白皮書附於法務或部落格文章，並引用對應檔案位置。
  - 若計畫讓 MegrezNT 追上 Swift 版 API，可依表格逐項評估移植成本。
  - 可補強自動化 API 對照（Swift `symbolgraph`, .NET Reflection, C++ `nm`）以利長期追蹤差異。

> 本白皮書彙整自倉庫當前版本：`vChewing-LibVanguard/Sources/_Modules/Homa`、`MegrezNT/Megrez/src`、`!LABS/mcbopomofo/Source/Engine/gramambular2`。如後續版本有重大更新，建議重新驗證。