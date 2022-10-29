---
parent: 使用手冊
sort: 70
has_toc: true
---
# 寫給漢音輸入法使用者

威注音輸入法並非與漢音輸入法對等替代的輸入法，雖然仍舊承襲了後者的一些使用習慣。

這篇文章主要說明一下後者的某些功能在前者當中的存無。

| 漢音輸入法的功能 | 威注音對該功能請求的響應 | 註解 / 原因 / 補記 |
|-|-|-|
| 游標在字詞前方選字 | ✅有實作，前後方都可以 | 漢音 Windows 版是在後方選字。 |
| Shift 切換中英輸入模式 | ✅有實作，可停用左 Shift 鍵的該功能 | 簡繁體中文 Windows 內建輸入法共同行為特徵。 |
| 英數全形輸入模式 | ❓不單獨提供 | 可摁 Shift+字母或符號，然後再自己選候選字。<br />組字區內沒有字時，摁 Shift+Space 輸入全形空格。 |
| 地址輸入模式 | ❌不提供 | 該功能的體驗很難做得精緻。 |
| 聲介韻亂序輸入 | ✅僅針對傳統四列注音排列提供該功能支援（傳統大千、傳統倚天、IBM、(偽)精業、神通） | 是大千聲韻並擊型注音輸入法都支援這個特性。另：因技術難度限制，威注音不針對諸如倚天 26 鍵、許氏、星光、酷音大千 26 鍵這樣的複合注音排列提供該功能支援。 |
| 在候選字內做選擇時的按鍵 | ✅相關功能全部承襲、可用 Space 呼叫選字窗 | 威注音另可使用其它按鍵來呼叫、操縱選字窗，請洽《[鍵盤熱鍵使用手冊](./shortcuts.md)》。 |
| 在候選詞 window 跳出現可有設定「滾動」次數 2 次或 4 次 | ❌沒搞懂 | 僅這句話，完全不夠用來分析功能需求。 |
| 行內跟隨 | ✅有實作 | 本來就受 macOS 內建的 InputMethodKit 支援。 |
| 浮動選字窗 | ✅有實作 | 受田所選字窗與 IMK 選字窗所支援。 |
| 浮動組字窗 | ✅有實作 | 需使用客體管理器指定要使用浮動組字窗的客體應用。 |
| Ctrl+Q 曖昧音字詞 | ❌不提供 | 該功能的體驗很難做得精緻，且目前威注音的辭典檢索系統做這種功能實在太麻煩：輸入法體積可能需要翻倍，或者需要為了效能而放棄 2018 年以前的機種，等。 |
| Shift+Delete 清空組字區 | ✅有實作 | 也可用 Shift+BackSpace 完成。 |
| 重複輸入剛剛敲過的字詞 | ❌不提供 | 該功能的體驗很難做得精緻，不如讓使用者自己剪貼簿複製再貼上。 |
| 遞交歷史記錄（智慧型重複句庫）| ❌不提供 | 該功能會帶來嚴重的個資安全隱患與隱私安全問題：沒有公司員工希望自己的敲句子的記錄被公司的老闆或資安部門來檢查。 |
| 專業詞庫 | ❌不原樣提供 | 威注音使用了其它的資料源，且鼓勵使用者自己新增自訂語彙。 |
| 在詞首用 Shift+Enter 就地加詞 | ❓改採微軟新注音 2003 的操作風格：使用 Shift+前後方向鍵來標記字詞範圍，然後敲 Enter 就地加詞 | 威注音允許將就地將選中的字詞範圍對應的字詞塞入語彙排除表、允許對既有詞用這種方式提升或降低權重。 |
| 略語 | ❌不提供 | 請活用使用者自訂語彙的功能。 |
| 字音反查 reverse-lookup | ❌不提供 | 目前威注音的辭典檢索系統做這種功能實在太麻煩：輸入法體積可能需要翻倍，或者需要為了效能而放棄 2018 年以前的機種，等。 |
| 取消最後一次辭彙自動轉換 | ❌不提供 | 目前組字引擎不支援該功能、且很難擴充該功能。使用輸入法本身的就地候選字輪替功能的話，可能會更快一些。 |
| Ctrl-6 工具箱 | ❌不提供 | 兩款輸入法的互動方式存在固有差異。 |
| Ctrl+3 符號清單 | ❓不預設提供（Option+(波浪)符號鍵） | 請根據軟體使用說明手冊自行擴充該符號表的內容。 |
| 漢音符號表「\」 | ❌暫不實作 | 相比酷音輸入法那種分類符號選單而言，漢音的「\」符號表功能不太適合這個年代的新手們記憶學習。 |

如果您希望在威注音 2.9.4 SP2 開始的版本當中繼續藉由「Option+(波浪)符號鍵」使用漢音 Ctrl+3 那樣的符號選單內容的話，請在威注音使用者辭典內新增下述內容（行數越高，排序越靠前）：

```
_punctuation_list ｀ 0.0
_punctuation_list ， 0.0
_punctuation_list 、 0.0
_punctuation_list 。 0.0
_punctuation_list ． 0.0
_punctuation_list ； 0.0
_punctuation_list ： 0.0
_punctuation_list ？ 0.0
_punctuation_list ！ 0.0
_punctuation_list ︰ 0.0
_punctuation_list ? 0.0
_punctuation_list ⋯ 0.0
_punctuation_list ‥ 0.0
_punctuation_list … 0.0
_punctuation_list ｜ 0.0
_punctuation_list — 0.0
_punctuation_list ︴ 0.0
_punctuation_list ﹏ 0.0
_punctuation_list （ 0.0
_punctuation_list ） 0.0
_punctuation_list ︵ 0.0
_punctuation_list ︶ 0.0
_punctuation_list 《 0.0
_punctuation_list 》 0.0
_punctuation_list ︽ 0.0
_punctuation_list ︾ 0.0
_punctuation_list 〈 0.0
_punctuation_list 〉 0.0
_punctuation_list ︿ 0.0
_punctuation_list ﹀ 0.0
_punctuation_list 【 0.0
_punctuation_list 】 0.0
_punctuation_list ︻ 0.0
_punctuation_list ︼ 0.0
_punctuation_list ｛ 0.0
_punctuation_list ｝ 0.0
_punctuation_list ︷ 0.0
_punctuation_list ︸ 0.0
_punctuation_list 〔 0.0
_punctuation_list 〕 0.0
_punctuation_list ︹ 0.0
_punctuation_list ︺ 0.0
_punctuation_list 「 0.0
_punctuation_list 」 0.0
_punctuation_list ﹁ 0.0
_punctuation_list ﹂ 0.0
_punctuation_list 『 0.0
_punctuation_list 』 0.0
_punctuation_list ﹃ 0.0
_punctuation_list ﹄ 0.0
_punctuation_list ＃ 0.0
_punctuation_list ＆ 0.0
_punctuation_list ＊ 0.0
_punctuation_list ※ 0.0
_punctuation_list § 0.0
_punctuation_list 〃 0.0
_punctuation_list ○ 0.0
_punctuation_list ● 0.0
_punctuation_list ◎ 0.0
_punctuation_list ㊣ 0.0
_punctuation_list △ 0.0
_punctuation_list ▽ 0.0
_punctuation_list ▲ 0.0
_punctuation_list ▼ 0.0
_punctuation_list ∴ 0.0
_punctuation_list ∵ 0.0
_punctuation_list ☆ 0.0
_punctuation_list ★ 0.0
_punctuation_list ◇ 0.0
_punctuation_list ◆ 0.0
_punctuation_list □ 0.0
_punctuation_list ■ 0.0
_punctuation_list ♀ 0.0
_punctuation_list ♂ 0.0
_punctuation_list → 0.0
_punctuation_list ← 0.0
_punctuation_list ↑ 0.0
_punctuation_list ↓ 0.0
_punctuation_list ↗ 0.0
_punctuation_list ↖ 0.0
_punctuation_list ↘ 0.0
_punctuation_list ↙ 0.0
_punctuation_list ㏕ 0.0
_punctuation_list ㎜ 0.0
_punctuation_list ㎝ 0.0
_punctuation_list ㎞ 0.0
_punctuation_list ㏎ 0.0
_punctuation_list ㎡ 0.0
_punctuation_list ㎎ 0.0
_punctuation_list ㎏ 0.0
_punctuation_list ㏄ 0.0
_punctuation_list ℃ 0.0
_punctuation_list ℉ 0.0
_punctuation_list ° 0.0
_punctuation_list ± 0.0
_punctuation_list × 0.0
_punctuation_list ÷ 0.0
_punctuation_list ≒ 0.0
_punctuation_list ≠ 0.0
_punctuation_list ≦ 0.0
_punctuation_list ≧ 0.0
_punctuation_list ∼ 0.0
_punctuation_list ∠ 0.0
_punctuation_list ⊥ 0.0
_punctuation_list ∟ 0.0
_punctuation_list ≡ 0.0
_punctuation_list ⊿ 0.0
_punctuation_list ∞ 0.0
_punctuation_list √ 0.0
_punctuation_list ┌ 0.0
_punctuation_list ┬ 0.0
_punctuation_list ┐ 0.0
_punctuation_list ├ 0.0
_punctuation_list ┼ 0.0
_punctuation_list ┤ 0.0
_punctuation_list └ 0.0
_punctuation_list ┴ 0.0
_punctuation_list ┘ 0.0
_punctuation_list ─ 0.0
_punctuation_list │ 0.0
_punctuation_list ═ 0.0
_punctuation_list ╞ 0.0
_punctuation_list ╪ 0.0
_punctuation_list ╡ 0.0
_punctuation_list ╱ 0.0
_punctuation_list ╲ 0.0
_punctuation_list ╳ 0.0
_punctuation_list ╭ 0.0
_punctuation_list ╮ 0.0
_punctuation_list ╰ 0.0
_punctuation_list ╯ 0.0
_punctuation_list ▁ 0.0
_punctuation_list ▂ 0.0
_punctuation_list ▃ 0.0
_punctuation_list ▄ 0.0
_punctuation_list ▅ 0.0
_punctuation_list ▆ 0.0
_punctuation_list ▇ 0.0
_punctuation_list █ 0.0
_punctuation_list ▏ 0.0
_punctuation_list ▎ 0.0
_punctuation_list ▍ 0.0
_punctuation_list ▌ 0.0
_punctuation_list ▋ 0.0
_punctuation_list ▊ 0.0
_punctuation_list ▉ 0.0
_punctuation_list ▔ 0.0
_punctuation_list 〡 0.0
_punctuation_list 〢 0.0
_punctuation_list 〣 0.0
_punctuation_list 〤 0.0
_punctuation_list 〥 0.0
_punctuation_list 〦 0.0
_punctuation_list 〧 0.0
_punctuation_list 〨 0.0
_punctuation_list 〩 0.0
_punctuation_list 十 0.0
_punctuation_list 卄 0.0
_punctuation_list 卅 0.0
_punctuation_list Ⅰ 0.0
_punctuation_list Ⅱ 0.0
_punctuation_list Ⅲ 0.0
_punctuation_list Ⅳ 0.0
_punctuation_list Ⅴ 0.0
_punctuation_list Ⅵ 0.0
_punctuation_list Ⅶ 0.0
_punctuation_list Ⅷ 0.0
_punctuation_list Ⅸ 0.0
_punctuation_list Ⅹ 0.0
_punctuation_list Α 0.0
_punctuation_list Β 0.0
_punctuation_list Γ 0.0
_punctuation_list Δ 0.0
_punctuation_list Ε 0.0
_punctuation_list Ζ 0.0
_punctuation_list Η 0.0
_punctuation_list Θ 0.0
_punctuation_list Ι 0.0
_punctuation_list Κ 0.0
_punctuation_list Λ 0.0
_punctuation_list Μ 0.0
_punctuation_list Ν 0.0
_punctuation_list Ξ 0.0
_punctuation_list Ο 0.0
_punctuation_list Π 0.0
_punctuation_list Ρ 0.0
_punctuation_list Σ 0.0
_punctuation_list Τ 0.0
_punctuation_list Υ 0.0
_punctuation_list Φ 0.0
_punctuation_list Χ 0.0
_punctuation_list Ψ 0.0
_punctuation_list Ω 0.0
_punctuation_list α 0.0
_punctuation_list β 0.0
_punctuation_list γ 0.0
_punctuation_list δ 0.0
_punctuation_list ε 0.0
_punctuation_list ζ 0.0
_punctuation_list η 0.0
_punctuation_list θ 0.0
_punctuation_list ι 0.0
_punctuation_list κ 0.0
_punctuation_list λ 0.0
_punctuation_list μ 0.0
_punctuation_list ν 0.0
_punctuation_list ξ 0.0
_punctuation_list ο 0.0
_punctuation_list π 0.0
_punctuation_list ρ 0.0
_punctuation_list σ 0.0
_punctuation_list τ 0.0
_punctuation_list υ 0.0
_punctuation_list φ 0.0
_punctuation_list χ 0.0
_punctuation_list ψ 0.0
_punctuation_list ω 0.0
```

$ EOF.