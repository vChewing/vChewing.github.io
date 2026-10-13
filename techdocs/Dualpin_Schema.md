---
parent: 技術文書
sort: 7
has_toc: true
permalink: /Dualpin_Schema.html
---

# 唯音輸入法：雙拼方案定義檔格式標準

本文說明唯音輸入法（vChewing）「雙拼」功能所使用之方案定義檔（Dualpin Schema）之格式標準。定義檔本身收錄於本倉庫之 [`valueadd/dualpin-schema-files/`](https://github.com/vChewing/vChewing.github.io/tree/main/valueadd/dualpin-schema-files) 目錄（[**點此前往下載頁面**](https://github.com/vChewing/vChewing.github.io/tree/main/valueadd/dualpin-schema-files)），該目錄並附有可直接用於驗證之 JSON Schema。

- 唯音**內建**之雙拼方案只有兩個：**GB/T 34947-2017** 與**微軟雙拼**。
- 其餘方案一律不內建，改由使用者自行下載該目錄之定義檔，於唯音之偏好設定匯入。
- 定義檔是一種純 JSON 資料檔：沒有程式碼、沒有巨集、不會連網、不會被執行。匯入時唯音會先校驗，**錯誤（E 系列）即拒收，警告（W 系列）僅提示**。

## 收錄之方案定義檔

| 檔案 | 方案 | 出處 |
| --- | --- | --- |
| `vChewing_dualpin_SmartABC_Schema.json` | 智能ABC（`dualPin.SmartABC`） | 朱守濤／北京大學，1990 |
| `vChewing_dualpin_PinyinJiajia_Schema.json` | 拼音加加（`dualPin.PYJJ`） | 廖恒毅／北京六合源，2000 |
| `vChewing_dualpin_Sogou_Schema.json` | 搜狗雙拼（`dualPin.Sogou`） | 搜狗，2006 前後 |
| `vChewing_dualpin_Unispim_Schema.json` | 紫光華宇（`dualPin.Unispim`） | 北京華宇（前身考拉輸入法），2000 前後 |
| `vChewing_dualpin_ZiranChou_Schema.json` | 周志農自然雙拼（`dualPin.ZiranChou`） | 周志農，1988 |
| `vChewing_dualpin_Xiaohe_Schema.json` | 小鶴雙拼（`dualPin.Xiaohe`） | 何海峰，2009 |
| `vChewing_dualpin_Sitong_Schema.json` | 四通雙拼（`dualPin.Sitong`） | 四通打字機，1985 前後 |
| `vChewing_dualpin_Schema.schema.json` | ——（格式規範，非方案） | 本專案 |

各檔之權利狀態與收錄理由，見文末〈收錄政策、出處與授權〉。

## 如何匯入

1. 自 `valueadd/dualpin-schema-files/` 下載所需之 `vChewing_dualpin_*_Schema.json`。
2. 開啟唯音輸入法之偏好設定，切到「鍵盤」頁，找到「雙拼方案:」一節。
3. 按「匯入雙拼方案…」，選取該 JSON 檔。
4. 匯入成功後，「雙拼方案:」選擇「自訂雙拼」即會使用該方案。

注意事項：

- **匯入之方案會整份取代現有之自訂雙拼方案**（不是合併，也不是新增一個條目）。
- 檔案大小上限為 **1 MiB**。
- 匯入之內容以 JSON 原文存放於唯音偏好設定之 `DualpinSchemaJSON`（程式碼中為 `UserDef.kDualpinSchemaJSON`），不另存成檔案；清除該偏好即等同移除。
- 校驗失敗時，唯音會列出錯誤（E 系列）；警告（W 系列）不影響匯入，但值得留意。
- 唯音舊版曾內建若干方案；若您的偏好值仍指向那些方案，唯音會自動回退為「微軟雙拼」。

## 檔案命名與基本要求

- 建議檔名為 `vChewing_dualpin_<rawTitle>_Schema.json`（例如 `vChewing_dualpin_Xiaohe_Schema.json`）。
- 檔案須以 **UTF-8** 編碼，內容須為**單一 JSON 物件**。
- 不得有註解，不得有尾隨逗號。
- 建議於物件開頭加入 `$schema` 欄位指向該目錄之 JSON Schema，編輯器即可即時校驗；唯音本身不使用該欄位。

```json
{
  "$schema": "https://vchewing.github.io/valueadd/dualpin-schema-files/vChewing_dualpin_Schema.schema.json",
  "rawID": "dualPin.Example",
  "rawTitle": "Example",
  "initials": { "b": "b", "p": "p", "m": "m" },
  "finals": { "a": "a", "o": "o", "e": "e" },
  "nullOnset": "finalInitial"
}
```

## 欄位規範

| 欄位 | 必填 | 型別 | 預設 | 語意 |
| --- | --- | --- | --- | --- |
| `$schema` | 否 | 字串 | —— | 僅供編輯器與驗證器辨識，唯音忽略。 |
| `rawID` | **是** | 字串 | —— | 方案之唯一識別名，須為反向域名形（E9）。 |
| `rawTitle` | **是** | 字串 | —— | 方案之原文標題，不得為空（E7）。 |
| `localizedTitle` | 否 | 物件（語系→字串） | `{}` | 標題之各語系譯名；缺 `en` 發 W8。 |
| `initials` | **是** | 物件（拼音→鍵） | —— | 聲母表。 |
| `finals` | **是** | 物件（拼音→鍵） | —— | 尾綴表。 |
| `nullOnset` | **是** | 字串或物件 | —— | 零聲母政策。 |
| `keyInterception` | 否 | 字串或物件 | `"none"` | 按鍵攔截政策（E6）。 |
| `autochopPolicy` | 否 | 字串 | `"disabled"` | 自動斷詞政策；非 `disabled` 發 W7。 |
| `overrides` | 否 | 物件（詞幹→碼） | `{}` | 詞幹到碼之強制覆寫（E8）。 |
| `aliases` | 否 | 物件（碼→詞幹） | `{}` | 額外可接受之別名碼（E5）。 |
| `acknowledgedUnreachable` | 否 | 字串陣列 | `[]` | 已知無法得碼之詞幹（E3／W1）；DIPE 不列於此。 |

### `rawID`

方案之唯一識別名，須為反向域名形：由 `.` 分隔、每段以拉丁字母開頭、可含拉丁字母數字與 `-`，例如 `dualPin.SmartABC`。不得為空、不得與另一個方案（含唯音內建之 `dualPin.Microsoft`、`dualPin.GBT17`）相衝。

### `rawTitle`

方案之原文標題，不得為空或全為空白。

### `localizedTitle`

語系標籤到標題之對照表，例如：

```json
"localizedTitle": { "en": "Xiaohe", "zh-Hant": "小鶴雙拼", "zh-Hans": "小鹤双拼", "ja": "小鶴双弁" }
```

唯音查表之順序為：**精確之語系標籤 → 去區域之標籤（`zh-Hant-TW` 會退而查 `zh-Hant`）→ 語言主標籤 → `en` → `rawTitle`**。比對時不分大小寫，`_` 與 `-` 等價。缺少 `en` 時仍可匯入，但會發 W8。

### `initials` 與 `finals`

兩張對照表，鍵為拼音片段（小寫拉丁字母；`ü` 可寫作 `ü`，亦可依 v 化慣例寫作 `v`），值為**恰一個字元**之按鍵。`initials` 之鍵為聲母，`finals` 之鍵為韻母（尾綴）。

```json
"initials": { "zh": "v", "ch": "i", "sh": "u", "b": "b", "p": "p" },
"finals": { "a": "a", "uo": "o", "iang": "l", "v": "v" }
```

值不得為空字串；`initials` 之值若多於一個字元，唯音只取首字元。鍵不得為聲調鍵（1 至 5、空白、`ˊ`、`ˇ`、`ˋ`、`˙`），亦不得為不可見字元（E4）。

### `nullOnset`

零聲母（沒有聲母）之音節如何起首，三種寫法：

| 寫法 | 語意 |
| --- | --- |
| `"finalInitial"` | 以尾綴鍵之首字元為起首鍵。 |
| `"finalInitialOrVerbatimDigraph"` | 尾綴恰為二字元時**原樣**輸出；否則取首字元。 |
| 單一鍵，如 `"o"` | 一律以該鍵為起首鍵（等價之寫法為 `{"fixedKey": "o"}`）。 |

### `keyInterception`

按鍵攔截政策，即「哪些鍵應被唯音攔下、不交給系統或其他輸入法」：

| 寫法 | 語意 |
| --- | --- |
| `"none"` | 不攔截（預設）。 |
| `"schemeAlphabet"` | 攔截本方案之全部可用鍵。 |
| `{"explicit": ["a", "b", ";"]}` | 明確列出所攔截之鍵。 |
| `{"explicit": "ab;"}` | 同上，以字串之各字元表示。 |
| `"ab;"` | 同上，寬容形之簡寫（非規範形）。 |

所列出之鍵若不在本方案之可用鍵內，即為 E6。

### `autochopPolicy`

自動斷詞政策，可為 `"disabled"`（預設）、`"backtrackToShorterReading"`、`"prefixCandidates"`、`"passThroughVerbatim"`。非 `"disabled"` 時唯音仍會接受，但會發 W7 提醒。

### `overrides`

詞幹到碼之強制覆寫，優先於兩表之推算結果：

```json
"overrides": { "dei": "dw" }
```

碼長必須恰為 2，否則即為 E8。

### `aliases`

額外可接受之碼到詞幹之對照：

```json
"aliases": { "ad": "ai", "ew": "ei" }
```

鍵為額外可接受之碼（恰 2 鍵），值為其所代表之詞幹。別名碼若與其他詞幹之主碼相撞，即為 E5。

### `acknowledgedUnreachable`

某些拼音詞幹在您之方案中無法得碼（例如方案刻意省略某些音節）。把它們列在此處，唯音即不再為它們發 E3；但仍會發 W1 提醒，以免您忘記。

本欄位之語意是「**可表達而刻意不表達**」。若某拼式是「本就不可表達」，則屬 DIPE，**不得**列在此處——見下。

### DIPE（雙拼不可表達之拼音表示式）

DIPE 係 Dualpin-Incompatible Pinyin Expression 之縮寫：該拼式存在於漢語拼音之拼式空間，卻不屬雙拼之鍵位空間。此清單由唯音引擎硬編碼認定（`dualpinIncompatiblePinyinExpressions`），現行僅一例：

- `eh`（孤立 ㄝ，僅用於嘆詞「欸」）。

其處理方式為：於**取碼之前**即略過。故 DIPE 詞幹

- 不發 E3、不發 W1，亦不進碼表；
- 不計入覆蓋率，僅記於校驗報告之 `ignoredStems`；
- 不影響匯入——匯入與否只看有無 E 系列錯誤。

零聲母政策不改變此事：DIPE 之判斷早於零聲母政策，故採 `finalInitial` 或 `finalInitialOrVerbatimDigraph` 之方案亦不會因而讓 `eh` 得碼。七份已發布之方案因此一律為「得碼 425／受校驗 426」（受校驗之清單含 DIPE 在內），`eh` 一律歸 `ignoredStems`。

**不要把 DIPE 詞幹列入 `acknowledgedUnreachable`。** 該欄位之語意是「可表達而刻意不表達」，而引擎在讀取該欄位之前即已略過 DIPE 詞幹；寫了不但不會有任何效果，還會誤導後續之維護者（含審閱此類定義檔之工具與人員）。

DIPE 清單之增修屬引擎之事，定義檔無法自行宣告。其認定之依據是「該拼式不屬雙拼之鍵位空間」；日後若真有方案須表達 `eh`，須先改引擎之 DIPE 清單。

## 唯音如何組碼

1. 詞幹先正規化：`nü` → `nv`、`lü` → `lv`（此時發 W4 提醒）。
2. 若 `overrides` 明列該詞幹，逕取其碼。
3. 否則以 `initials` 之鍵作**前綴**匹配，取**最長**者（故 `zh`／`ch`／`sh` 勝過其單鍵）。
4. 剩餘部分以 `finals` **全等**查表（不採後綴吞噬）。
5. 有聲母者：聲母鍵 ＋ 尾綴鍵。無聲母者：依 `nullOnset` 政策起首（見上），再接著尾綴鍵。
6. 碼長恆為 **2 鍵**。
7. DIPE（雙拼不可表達之拼音表示式，現行僅 `eh`）於取碼前即被靜默略過，不列 E3、不列 W1，見前文〈DIPE〉。

## 可用鍵（alphabet）之推算

定義檔**不載**「可用鍵」清單，唯音會自行推算：

1. 先取兩表之全部值（即各鍵）。
2. 再依 `nullOnset` 政策補上可能用到之鍵：`{"fixedKey": "o"}` 補 `o`；`"finalInitial"` 補兩表鍵之首字元；`"finalInitialOrVerbatimDigraph"` 除首字元外，尾綴恰二字元者再補其二字元。

若某個鍵在兩表中出現、卻未被任何碼用到，唯音會發 W5，提醒您檢查方案。

## 校驗

### 以 JSON Schema 校驗

該目錄之 `vChewing_dualpin_Schema.schema.json` 為 [JSON Schema](https://json-schema.org/) draft 2020-12 格式，可用任何相容之驗證器檢驗：

```sh
# 以 check-jsonschema（Python）為例
check-jsonschema --schemafile vChewing_dualpin_Schema.schema.json my-scheme.json

# 或以 jsonschema 模組為例
python3 -m jsonschema -i my-scheme.json vChewing_dualpin_Schema.schema.json
```

若於定義檔開頭加入 `$schema` 欄位（見上），多數編輯器（含 VS Code）亦會即時標示問題。

JSON Schema 能規範欄位之存在、型別、格式與字元集；以下規則涉及跨欄位之推算（例如「碼是否只用到了兩表所給之鍵」），則由唯音匯入時校驗。

### 唯音之校驗規則

**錯誤（E 系列）——一旦出現即拒收：**

| 代號 | 內容 |
| --- | --- |
| E1 | 某詞幹之碼含「可用鍵」以外之鍵。 |
| E2 | 某詞幹之碼長不是 2。 |
| E3 | 某詞幹無法得碼、非 DIPE，且未列於 `acknowledgedUnreachable`。 |
| E4 | 可用鍵含聲調鍵（1 至 5、空白、`ˊ`、`ˇ`、`ˋ`、`˙`）或不可見字元。 |
| E5 | 別名碼與其他詞幹之主碼相撞。 |
| E6 | `keyInterception` 所列之鍵不在可用鍵內。 |
| E7 | `rawTitle` 為空或全為空白。 |
| E8 | `overrides` 之碼長不是 2。 |
| E9 | `rawID` 為空、非反向域名形，或與既有方案相衝。 |

**警告（W 系列）——僅提示，不影響匯入：**

| 代號 | 內容 |
| --- | --- |
| W1 | 提醒 `acknowledgedUnreachable` 所列之詞幹（DIPE 不列於此）。 |
| W2 | 重碼：多個詞幹共用同一碼（雙拼之常態，僅供參考）。 |
| W3 | 某碼用到了唯音主程式保留之鍵（`` ` ``、`~`、`¥`、`\`），但未列於 `keyInterception`。 |
| W4 | 載入時對 `n`／`l` 後之 `ü` 作了 v 化。 |
| W5 | 兩表所給之鍵未被任何碼用到。 |
| W7 | `autochopPolicy` 不是 `disabled`。 |
| W8 | `localizedTitle` 缺少 `en`。 |

## 收錄政策、出處與授權

這些定義檔之定位是「使用者自行取用之鍵位對照資料」：唯音**不內建**這些方案，也不隨安裝檔散布它們；使用者下載後自行匯入，等同於自行輸入一份鍵位表。

| 檔案 | 權利人／作者 | 權利狀態之說明 |
| --- | --- | --- |
| `vChewing_dualpin_SmartABC_Schema.json` | 朱守濤／北京大學（1990） | 權利人明確，曾授權微軟、IBM、Compaq、HP、Apple 等廠商。 |
| `vChewing_dualpin_PinyinJiajia_Schema.json` | 廖恒毅／北京六合源（2000） | 商業共享軟體，未見公開之鍵位表授權聲明。 |
| `vChewing_dualpin_Sogou_Schema.json` | 搜狗（企業） | 企業持有；其專利未見針對鍵位表本身者。 |
| `vChewing_dualpin_Unispim_Schema.json` | 北京華宇（前身考拉輸入法） | 2014 年部分開源（含 LGPL 2.1），對最終用戶免費。 |
| `vChewing_dualpin_ZiranChou_Schema.json` | 周志農（1988；1994 年軟體著作權登記） | 版權明確，作者同意免費授權；相關專利申請視為撤回。 |
| `vChewing_dualpin_Xiaohe_Schema.json` | 何海峰（2009） | 作者提供愛好者免費下載使用，但不得用於商業目的。 |
| `vChewing_dualpin_Sitong_Schema.json` | 四通打字機（1985 前後） | 權利人歸屬不清；微軟亦曾表示無法取得合法授權。 |

鍵位對照表本身是操作方法／資料事實層面之資訊；惟本專案尊重各權利人之意願。**若您是權利人或其代理人，認為此處之收錄不妥，請於本倉庫開一個 issue，我們會即刻移除對應檔案。**

其中四通雙拼之權利狀態最不明確：其鍵位見於四通打字機之鍵盤刻印，著作權利之歸屬與繼受情況均無從查證。本目錄收錄該檔純為鍵位對照之便，使用者請自行斟酌是否取用。

唯音**內建**之兩個方案為 GB/T 34947-2017（推薦性官標，其技術方案無權利人）與微軟雙拼（源自自然碼，1994 年授權微軟），故無需自行匯入。

## 貢獻

歡迎以 Pull Request 或 issue 提供新方案或修正：

- 倉庫：<https://github.com/vChewing/vChewing.github.io>（定義檔置於 `valueadd/dualpin-schema-files/`）。
- 請確認檔案可通過 `vChewing_dualpin_Schema.schema.json` 之校驗，且匯入唯音時無 E 系列錯誤。
- 請於 PR 或 issue 中說明方案之出處、作者與權利狀態。
- 檔名請依 `vChewing_dualpin_<rawTitle>_Schema.json` 之慣例。
