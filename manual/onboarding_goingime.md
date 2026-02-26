---
parent: 使用手冊
sort: 76
has_toc: true
---
# 寫給自然輸入法的使用者

> 本文提及的自然輸入法版本為所有使用姜天戩菸草注音引擎版本的自然輸入法。截至本文最後一次更新時，已確認至少自然輸入法 v10 & v11 & v12 & v13 使用該引擎（及與此對應的資料架構）。

自然輸入法的使用者群體往往都攢了十幾年甚至二十幾年的使用者片語儲備量、導致輸入法遷移上的困難。然而，由於自然輸入法是商業產品的緣故，往唯音輸入法內部集成「從自然輸入法遷移資料的功能」這種事情可能不太合適。目前的策略是引導使用者使用單獨的 FOSS 開放原始碼的工具「[NCIUserDBKit](https://github.com/vChewing/NCIUserDBKit)」析出上述版本的自然輸入法的使用者片語、然後自行決策如何將析出的資料整理使用。

這套工具是 CLI 工具，需要用 git 工具克隆到您的電腦來使用。

- macOS 系統下的話，clone 完畢之後，在確保系統已經安裝至少 Swift 6.1（或至少 Xcode 15.x）。然後，在專案倉庫目錄下直接運行 `swift run ncidump dumpall`。
- Windows 系統下的話，請安裝至少 .NET 10。之後，在專案倉庫目錄內的 `WinNT` 目錄下運行 `dotnet run --project WinNT/NCIUserDBCLI -- dumpall`。

會出現這種終端列印結果：

```
--- /Users/YourUnixUsername/Library/Application Support/GOING11/UserData/Going11/profile.db ---
=== 使用者自訂詞條 (isCustom == 1, 依 timestamp 排序) ===
共 3 筆
  提供  ㄊㄧˊ-ㄍㄨㄥ  (hits=1, ts=1650506949)
  像是  ㄒㄧㄤˋ-ㄕˋ  (hits=1, ts=1650506953)
  星穹列車  ㄒㄧㄥ-ㄑㄩㄥˊ-ㄌㄧㄝˋ-ㄔㄜ  (hits=1, ts=1771585331)

--- /Users/YourUnixUsername/Library/Application Support/GOING12/UserData/Going12/profile.db ---
=== 使用者自訂詞條 (isCustom == 1, 依 timestamp 排序) ===
共 0 筆

--- /Users/YourUnixUsername/Library/Application Support/GOING13/UserData/Going13/profile.db ---
=== 使用者自訂詞條 (isCustom == 1, 依 timestamp 排序) ===
共 2 筆
  公象  ㄍㄨㄥ-ㄒㄧㄤˋ  (hits=1, ts=1650506935)
  星穹列車  ㄒㄧㄥ-ㄑㄩㄥˊ-ㄌㄧㄝˋ-ㄔㄜ  (hits=1, ts=1771585331)
~/Repos/!vChewing/NCIUserDBKit>
```

你可以看到第一欄是詞語、第二欄是以 `-` 銜接的注音讀音串。這個組合可以直接用於唯音輸入法的使用者片語檔案內。剩下的 ts 是時間戳，用來排列資料順序。

$ EOF.
