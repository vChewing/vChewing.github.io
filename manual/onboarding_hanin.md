---
parent: 使用手冊
sort: 70
has_toc: true
---
# 寫給漢音輸入法使用者

威注音輸入法並非與漢音輸入法對等替代的輸入法，雖然仍舊承襲了後者的一些使用習慣。

這篇文章主要說明一下後者的某些功能在前者當中的存無。

以下功能以威注音 3.4.0 版為準。

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
| 字音反查 reverse-lookup | ✅有實作 | 詳見輸入法選單內「注音反查…」一項。 |
| 取消最後一次辭彙自動轉換 | ❌不提供 | 目前組字引擎不支援該功能、且很難擴充該功能。使用輸入法本身的就地候選字輪替功能的話，可能會更快一些。 |
| Ctrl-6 工具箱 | ❌不提供 | 兩款輸入法的互動方式存在固有差異。 |
| Ctrl+3 符號清單 | ❓改為 Option+Shift+(波浪)符號鍵 | 可根據軟體使用說明手冊自行擴充該符號表的內容。 |
| 漢音符號表「\」 | ✅有實作 | 漢音輸入法原版的「\」鍵功能得在輸入法偏好設定內手動啟用；另可連續敲「Option+(波浪)符號鍵」來切換該模式的開關（這樣也可以切換到 Big5 / GB 內碼模式）。 |

如果您希望在威注音 2.9.4 SP2 開始 **至 3.3.5 版為止** 的版本當中繼續藉由「Option+(波浪)符號鍵」使用漢音 Ctrl+3 那樣的符號選單內容的話，請在威注音使用者辭典內新增下述內容（行數越高，排序越靠前）：

```
　 _punctuation_list
， _punctuation_list
、 _punctuation_list
。 _punctuation_list
． _punctuation_list
‧ _punctuation_list
； _punctuation_list
： _punctuation_list
？ _punctuation_list
！ _punctuation_list
︰ _punctuation_list
… _punctuation_list
‥ _punctuation_list
﹐ _punctuation_list
﹑ _punctuation_list
﹒ _punctuation_list
· _punctuation_list
﹔ _punctuation_list
﹕ _punctuation_list
﹖ _punctuation_list
﹗ _punctuation_list
｜ _punctuation_list
– _punctuation_list
︱ _punctuation_list
— _punctuation_list
︳ _punctuation_list
╴ _punctuation_list
︴ _punctuation_list
﹏ _punctuation_list
（ _punctuation_list
） _punctuation_list
︵ _punctuation_list
︶ _punctuation_list
｛ _punctuation_list
｝ _punctuation_list
︷ _punctuation_list
︸ _punctuation_list
〔 _punctuation_list
〕 _punctuation_list
︹ _punctuation_list
︺ _punctuation_list
【 _punctuation_list
】 _punctuation_list
︻ _punctuation_list
︼ _punctuation_list
《 _punctuation_list
》 _punctuation_list
︽ _punctuation_list
︾ _punctuation_list
〈 _punctuation_list
〉 _punctuation_list
︿ _punctuation_list
﹀ _punctuation_list
「 _punctuation_list
」 _punctuation_list
﹁ _punctuation_list
﹂ _punctuation_list
『 _punctuation_list
』 _punctuation_list
﹃ _punctuation_list
﹄ _punctuation_list
﹙ _punctuation_list
﹚ _punctuation_list
﹛ _punctuation_list
﹜ _punctuation_list
﹝ _punctuation_list
﹞ _punctuation_list
‘ _punctuation_list
’ _punctuation_list
“ _punctuation_list
” _punctuation_list
〝 _punctuation_list
〞 _punctuation_list
‵ _punctuation_list
′ _punctuation_list
＃ _punctuation_list
＆ _punctuation_list
＊ _punctuation_list
※ _punctuation_list
§ _punctuation_list
〃 _punctuation_list
○ _punctuation_list
● _punctuation_list
△ _punctuation_list
▲ _punctuation_list
◎ _punctuation_list
☆ _punctuation_list
★ _punctuation_list
◇ _punctuation_list
◆ _punctuation_list
□ _punctuation_list
■ _punctuation_list
▽ _punctuation_list
▼ _punctuation_list
㊣ _punctuation_list
℅ _punctuation_list
¯ _punctuation_list
￣ _punctuation_list
＿ _punctuation_list
ˍ _punctuation_list
﹉ _punctuation_list
﹊ _punctuation_list
﹍ _punctuation_list
﹎ _punctuation_list
﹋ _punctuation_list
﹌ _punctuation_list
＆ _punctuation_list
﹠ _punctuation_list
﹡ _punctuation_list
＋ _punctuation_list
－ _punctuation_list
× _punctuation_list
÷ _punctuation_list
± _punctuation_list
√ _punctuation_list
＜ _punctuation_list
＞ _punctuation_list
＝ _punctuation_list
≦ _punctuation_list
≧ _punctuation_list
≠ _punctuation_list
∞ _punctuation_list
≒ _punctuation_list
≡ _punctuation_list
﹢ _punctuation_list
﹣ _punctuation_list
﹤ _punctuation_list
﹥ _punctuation_list
﹦ _punctuation_list
～ _punctuation_list
∩ _punctuation_list
∪ _punctuation_list
⊥ _punctuation_list
∠ _punctuation_list
∟ _punctuation_list
⊿ _punctuation_list
㏒ _punctuation_list
㏑ _punctuation_list
∫ _punctuation_list
∮ _punctuation_list
∵ _punctuation_list
∴ _punctuation_list
♀ _punctuation_list
♂ _punctuation_list
⊕ _punctuation_list
⊙ _punctuation_list
↑ _punctuation_list
↓ _punctuation_list
← _punctuation_list
→ _punctuation_list
↖ _punctuation_list
↗ _punctuation_list
↙ _punctuation_list
↘ _punctuation_list
∥ _punctuation_list
∣ _punctuation_list
／ _punctuation_list
＼ _punctuation_list
∕ _punctuation_list
﹨ _punctuation_list
＄ _punctuation_list
￥ _punctuation_list
〒 _punctuation_list
￠ _punctuation_list
￡ _punctuation_list
％ _punctuation_list
＠ _punctuation_list
℃ _punctuation_list
℉ _punctuation_list
﹩ _punctuation_list
﹪ _punctuation_list
﹫ _punctuation_list
㏕ _punctuation_list
㎜ _punctuation_list
㎝ _punctuation_list
㎞ _punctuation_list
㏎ _punctuation_list
㎡ _punctuation_list
㎎ _punctuation_list
㎏ _punctuation_list
㏄ _punctuation_list
° _punctuation_list
兙 _punctuation_list
兛 _punctuation_list
兞 _punctuation_list
兝 _punctuation_list
兡 _punctuation_list
兣 _punctuation_list
嗧 _punctuation_list
瓩 _punctuation_list
糎 _punctuation_list
▁ _punctuation_list
▂ _punctuation_list
▃ _punctuation_list
▄ _punctuation_list
▅ _punctuation_list
▆ _punctuation_list
▇ _punctuation_list
█ _punctuation_list
▏ _punctuation_list
▎ _punctuation_list
▍ _punctuation_list
▌ _punctuation_list
▋ _punctuation_list
▊ _punctuation_list
▉ _punctuation_list
┼ _punctuation_list
┴ _punctuation_list
┬ _punctuation_list
┤ _punctuation_list
├ _punctuation_list
▔ _punctuation_list
─ _punctuation_list
│ _punctuation_list
▕ _punctuation_list
┌ _punctuation_list
┐ _punctuation_list
└ _punctuation_list
┘ _punctuation_list
╭ _punctuation_list
╮ _punctuation_list
╰ _punctuation_list
╯ _punctuation_list
═ _punctuation_list
╞ _punctuation_list
╪ _punctuation_list
╡ _punctuation_list
◢ _punctuation_list
◣ _punctuation_list
◥ _punctuation_list
◤ _punctuation_list
╱ _punctuation_list
╲ _punctuation_list
╳ _punctuation_list
０ _punctuation_list
１ _punctuation_list
２ _punctuation_list
３ _punctuation_list
４ _punctuation_list
５ _punctuation_list
６ _punctuation_list
７ _punctuation_list
８ _punctuation_list
９ _punctuation_list
Ⅰ _punctuation_list
Ⅱ _punctuation_list
Ⅲ _punctuation_list
Ⅳ _punctuation_list
Ⅴ _punctuation_list
Ⅵ _punctuation_list
Ⅶ _punctuation_list
Ⅷ _punctuation_list
Ⅸ _punctuation_list
Ⅹ _punctuation_list
〡 _punctuation_list
〢 _punctuation_list
〣 _punctuation_list
〤 _punctuation_list
〥 _punctuation_list
〦 _punctuation_list
〧 _punctuation_list
〨 _punctuation_list
〩 _punctuation_list
十 _punctuation_list
卄 _punctuation_list
卅 _punctuation_list
Ａ _punctuation_list
Ｂ _punctuation_list
Ｃ _punctuation_list
Ｄ _punctuation_list
Ｅ _punctuation_list
Ｆ _punctuation_list
Ｇ _punctuation_list
Ｈ _punctuation_list
Ｉ _punctuation_list
Ｊ _punctuation_list
Ｋ _punctuation_list
Ｌ _punctuation_list
Ｍ _punctuation_list
Ｎ _punctuation_list
Ｏ _punctuation_list
Ｐ _punctuation_list
Ｑ _punctuation_list
Ｒ _punctuation_list
Ｓ _punctuation_list
Ｔ _punctuation_list
Ｕ _punctuation_list
Ｖ _punctuation_list
Ｗ _punctuation_list
Ｘ _punctuation_list
Ｙ _punctuation_list
Ｚ _punctuation_list
ａ _punctuation_list
ｂ _punctuation_list
ｃ _punctuation_list
ｄ _punctuation_list
ｅ _punctuation_list
ｆ _punctuation_list
ｇ _punctuation_list
ｈ _punctuation_list
ｉ _punctuation_list
ｊ _punctuation_list
ｋ _punctuation_list
ｌ _punctuation_list
ｍ _punctuation_list
ｎ _punctuation_list
ｏ _punctuation_list
ｐ _punctuation_list
ｑ _punctuation_list
ｒ _punctuation_list
ｓ _punctuation_list
ｔ _punctuation_list
ｕ _punctuation_list
ｖ _punctuation_list
ｗ _punctuation_list
ｘ _punctuation_list
ｙ _punctuation_list
ｚ _punctuation_list
Α _punctuation_list
Β _punctuation_list
Γ _punctuation_list
Δ _punctuation_list
Ε _punctuation_list
Ζ _punctuation_list
Η _punctuation_list
Θ _punctuation_list
Ι _punctuation_list
Κ _punctuation_list
Λ _punctuation_list
Μ _punctuation_list
Ν _punctuation_list
Ξ _punctuation_list
Ο _punctuation_list
Π _punctuation_list
Ρ _punctuation_list
Σ _punctuation_list
Τ _punctuation_list
Υ _punctuation_list
Φ _punctuation_list
Χ _punctuation_list
Ψ _punctuation_list
Ω _punctuation_list
α _punctuation_list
β _punctuation_list
γ _punctuation_list
δ _punctuation_list
ε _punctuation_list
ζ _punctuation_list
η _punctuation_list
θ _punctuation_list
ι _punctuation_list
κ _punctuation_list
λ _punctuation_list
μ _punctuation_list
ν _punctuation_list
ξ _punctuation_list
ο _punctuation_list
π _punctuation_list
ρ _punctuation_list
σ _punctuation_list
τ _punctuation_list
υ _punctuation_list
φ _punctuation_list
χ _punctuation_list
ψ _punctuation_list
ω _punctuation_list
ㄅ _punctuation_list
ㄆ _punctuation_list
ㄇ _punctuation_list
ㄈ _punctuation_list
ㄉ _punctuation_list
ㄊ _punctuation_list
ㄋ _punctuation_list
ㄌ _punctuation_list
ㄍ _punctuation_list
ㄎ _punctuation_list
ㄏ _punctuation_list
ㄐ _punctuation_list
ㄑ _punctuation_list
ㄒ _punctuation_list
ㄓ _punctuation_list
ㄔ _punctuation_list
ㄕ _punctuation_list
ㄖ _punctuation_list
ㄗ _punctuation_list
ㄘ _punctuation_list
ㄙ _punctuation_list
ㄚ _punctuation_list
ㄛ _punctuation_list
ㄜ _punctuation_list
ㄝ _punctuation_list
ㄞ _punctuation_list
ㄟ _punctuation_list
ㄠ _punctuation_list
ㄡ _punctuation_list
ㄢ _punctuation_list
ㄣ _punctuation_list
ㄤ _punctuation_list
ㄥ _punctuation_list
ㄦ _punctuation_list
ㄧ _punctuation_list
ㄨ _punctuation_list
ㄩ _punctuation_list
˙ _punctuation_list
ˉ _punctuation_list
ˊ _punctuation_list
ˇ _punctuation_list
ˋ _punctuation_list
╔ _punctuation_list
╦ _punctuation_list
╗ _punctuation_list
╠ _punctuation_list
╬ _punctuation_list
╣ _punctuation_list
╚ _punctuation_list
╩ _punctuation_list
╝ _punctuation_list
╒ _punctuation_list
╤ _punctuation_list
╕ _punctuation_list
╞ _punctuation_list
╪ _punctuation_list
╡ _punctuation_list
╘ _punctuation_list
╧ _punctuation_list
╛ _punctuation_list
╓ _punctuation_list
╥ _punctuation_list
╖ _punctuation_list
╟ _punctuation_list
╫ _punctuation_list
╢ _punctuation_list
╙ _punctuation_list
╨ _punctuation_list
╜ _punctuation_list
║ _punctuation_list
═ _punctuation_list
╭ _punctuation_list
╮ _punctuation_list
╰ _punctuation_list
╯ _punctuation_list
▓ _punctuation_list
```

$ EOF.
