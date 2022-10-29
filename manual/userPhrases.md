---
parent: 使用手冊
sort: 5
has_toc: true
---
# 使用者語彙資料夾

- [使用者語彙資料夾](#使用者語彙資料夾)
		- [A. 使用者辭典](#a-使用者辭典)
		- [B. 使用者繪文字辭典](#b-使用者繪文字辭典)
		- [C. 使用者聯想詞](#c-使用者聯想詞)
		- [D. 語彙濾除表](#d-語彙濾除表)
		- [E. 語彙置換表](#e-語彙置換表)
		- [F. 逐字選字模式注音字序表](#f-逐字選字模式注音字序表)
		- [G. 自訂分層分類符號表](#g-自訂分層分類符號表)

威注音輸入法的當前使用者語彙目錄可以從輸入法選單的「開啟使用者辭典資料夾」的方式直接存取。您可以在輸入法偏好設定內更改使用者辭典資料夾。

該資料夾內的的常駐檔案如下：

> - 「由威注音輸入法本體以外的程式」對該資料夾所做出的任何修改，都會使該資料夾的所有被下述表格當中提及的內容被重新載入。
> - 「整理」表明威注音會在載入該當檔案時先整理格式、再讀取內容。
> - 「必需？」表明該檔案一定會存在。不存在的話，輸入法會嘗試建立原廠範本檔案。但凡**非必需**的檔案，都只會在使用者手動創建的時候才會起作用。

| 檔案名稱                                                     | 整理 | 檔案用途性質 | 必需？ |
|--------------------------------------------------------------|------------------|:---------------|----------|
| userdata-cht.txt<br />userdata-chs.txt                       | 是   | 使用者辭典 | 是       |
| usersymbolphrases-chs.txt<br />usersymbolphrases-cht.txt     | 是   | 使用者繪文字辭典 | 是       |
| associatedPhrases-chs.txt<br />associatedPhrases-cht.txt     | 是   | 使用者聯想詞 | 是       |
| exclude-phrases-cht.txt<br />exclude-phrases-chs.txt         | 是   | 語彙濾除表 | 是       |
| phrases-replacement-cht.txt<br />phrases-replacement-chs.txt | 是   | 語彙置換表 | 是       |
| data-plain-bpmf-cht.plist<br />data-plain-bpmf-chs.plist     | 否   | 逐字選字模式注音字序表 | 是       |
| symbols.dat                                                  | 否   | 自訂分層分類符號表 | 否       |

上表當中的**以 .txt 結尾的檔案**在被輸入法讀取時，有這幾個**共性**：

- 如果輸入法檢測不到合規的 Pragma Header 檔案頭標記的話，會自動整理其格式：
    - 所有 CR 換行都會被置換成 LF 換行、且去重複。
    - 所有種類的空格（無論全半形）與 Tab 都會被轉成 ASCII 半形空格、且去重複。
    - 在此基礎上，行首與行尾的空格會被剔除，且所有重複行都會被剔除。
    - 檔案被整理之後，會在檔案開頭留下 Pragma Header 檔案頭標記。
- 該檔案內容的行排序與選字窗內的內容排序成反比（所在行數越高，在選字窗當中越是會被先列出），除非手動指定了特殊的有效權重。
- 任何一行內，所有以 ASCII 井號「`#`」開頭的內容都會在資料讀取時被忽視。

上述的很多檔案在輸入法選單內都有專門的編輯入口，但其中有一些檔案的編輯入口**需要您在「當前程式正在準備接收文字輸入」的時候「摁著 Option 再點開輸入法選單」才會出現**。

同理，如果您摁著 Option 再點這些選單入口的話，往往會同時開啟簡體中文與繁體中文的檔案、供您同時編輯。

### A. 使用者辭典

> ⚠️ 該內容的編輯方式在輸入法選單當中的入口為「編輯威注音自訂語彙…」。

使用者自造詞都是塞在這個目錄的。如果您使用了就地加詞功能，則就地新增的詞會在這裡出現。最好是針對 `-chs.txt` 和 `-cht.txt` 同時擴充簡體中文與繁體中文的使用者辭典內容。當您就地加詞的時候，這兩個檔案都會被寫入，但其中與當前輸入法簡繁體模式不對應的那個檔案被寫入的內容是以繁簡轉換的方式實現的、有時可能需要人工檢查其準確性。

在該檔案內新增語彙的方式有兩種：

1. 先寫詞，再寫注音，但不寫權重。兩者之間用半形空格隔開，注音讀音之間用 ASCII 減號銜接。
   ```
   我是自訂語彙 ㄨㄛˇ-ㄕˋ-ㄗˋ-ㄉㄧㄥˋ-ㄩˇ-ㄏㄨㄟˋ
   ```
   不寫權重的自訂語彙都會被賦以「0」最高權重。寫了大於零的權重的話，則會被強制乘以「-1」。
2. 與上文相同，但在注音之後空一格再寫權重。權重建議設定在 [-9.5, 0] 這個全閉區間內。過大的話，可能會影響組字引擎正常組字；過小的話，一旦小於等於「-12」，則不會被半衰記憶模組所觀測。
   ```
   我是被降權的語彙 ㄨㄛˇ-ㄕˋ-ㄅㄟˋ-ㄐㄧㄤˋ-ㄑㄩㄢˊ-ㄉㄜ˙-ㄩˇ-ㄏㄨㄟˋ -114.514
   ```
   其中，「-114.514」是以野獸常數指定的懲戒權重。被賦以這個權重的詞會被組字引擎在自動爬軌組字時直接無視。威注音輸入法的「就地降頻」功能會在使用者辭典內重新加入被標記的詞音配對、且賦以該懲戒權重。

另外，「Option+符號鍵」的選單內容可在這個檔案內擴充，只需將讀音鍵設為「`_punctuation_list`」即可。範例：
```
？ _punctuation_list
！ _punctuation_list
︰ _punctuation_list
```

### B. 使用者繪文字辭典

與使用者辭典類似，但會被統一賦以的權重是「-12」。使用者無法指定其權重。

該檔案主要負責存放繪文字、以及包含繪文字的詞組。

每一行的撰寫格式為「先寫詞，再寫注音」，兩者之間用半形空格隔開，注音讀音之間用 ASCII 減號銜接。
```
⚠︎ ㄐㄧㄥˇ-ㄍㄠˋ
```

### C. 使用者聯想詞

使用者聯想詞的格式與 Windows XP 的傳統注音（ㄅ半注音）關聯詞檔案格式一樣，但要求檔案編碼必須只能是 UTF-8 編碼。該格式為「首字 去首字的候選字1 去首字的候選字2 ...」，用半形空格隔開：
```
天 涼好個秋 天向上 上人間 兵 堂
```
威注音的使用者聯想詞模組還可給首字指定讀音，但這會使該行資料**無法作用於無限聯想輸入**，所以不推薦使用。只需將首字改寫為「`(讀音,首字)`」即可。每行格式如下：
```
(ㄨㄟˊ,為) 師 人
(ㄨㄟˋ,為) 了 人民服務
```

### D. 語彙濾除表

語彙濾除表僅用來存放詞音配對，格式與使用者繪文字辭典檔案雷同。
所有藉由就地刪詞功能刪除的詞彙，都會在這裡出現詞音配對。這樣一來，出現在該表內的配對內容就不會被交給組字引擎、不會在選字窗內出現。範例格式參考如下：
```
北七 ㄅㄟˇ-ㄑㄧ
```

### E. 語彙置換表

> 威注音輸入法的原廠繁體中文語彙庫採當代繁體中文實質上慣用的很多寫法，比如「答覆」「回覆」（都是 response / reply 的意思）。但在某些場合可能會被要求使用「答復」「回復」。這種情況下，語彙置換表就可以派上用場。

語彙置換表用來從資料層面自動置換詞語本身。每一行的撰寫格式為「先寫要置換的對象詞，再寫要置換成的新詞」，兩者之間用半形空格隔開。
```
歐陽修 歐陽脩
```

> ⚠️ 注意：該功能無法就原廠辭典當中的單個記錄詞做內容置換，因為置換對象必須是整個記錄詞。比如說 如果只添入「修 脩」的記錄的話，不會讓「歐陽修」被訂正為「歐陽脩」。

### F. 逐字選字模式注音字序表

該 plist 檔案會始終存在，專門用來指定「逐字選字模式」當中的注音候選字的排序。預設情況下，威注音會生成一個 0KB 的假檔案用來佔位，但您可以隨時編輯裡面的內容。有些使用者可能已經習慣於 OpenVanilla 或者ㄅ半注音的原廠候選字排序，但威注音出於某些原因不太方便以原廠辭典的方式現成提供這樣的資料檔案（更何況會與原廠辭典內容的排序互相矛盾），所以就只能給出這種開放手段、讓使用者們有自己完成自訂需求的空間。

當輸入法在讀入逐字選字模式注音字序表的 plist 檔案時，裡面的內容會被先插入到選字窗當中的候選字清單內、再插入那些只有原廠語彙庫才有的內容。

編輯 plist 檔案的工具有很多。最著名的免費工具就是 Xcode，但實在太肥（幾十個 GB）。還有一個輕量級的免費選擇就是使用 [Microsoft Visual Studio Code (VSCode)](https://code.visualstudio.com/) 搭配 [Binary Plist 功能模組](https://marketplace.visualstudio.com/items?itemName=dnicolson.binary-plist)。當然，Xcode 與 VSCode 在這裡都是牛鼎烹雞。如果想要專門的「只做這一種事情」的工具的話，很多這種 plist 小工具 app 都是收費的，比如 PlistEdit Pro 等。

如果您不用 binary plist 的話，BBEdit 等純文字編輯軟體都可以拿來編輯檔案內容。但威注音輸入法讀取這種明文 plist 內容的速度會很慢就是了。範例檔案內容如下：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ㄅㄚ</key>
	<string>八捌巴疤芭笆粑叭扒豝吧仈朳峇</string>
	<key>ㄅㄚˇ</key>
	<string>把靶鈀</string>
	<key>ㄅㄚˊ</key>
	<string>拔跋鈸魃茇鼥軷犮菝胈詙</string>
	<key>ㄅㄚˋ</key>
	<string>罷爸霸壩耙弝灞伯猈</string>
	<key>ㄅㄚ˙</key>
	<string>吧罷琶杷</string>
	<key>ㄩㄥˋ</key>
	<string>用佣醟</string>
</dict>
</plist>
```

您也可以隨時用 plutil 或者 plistutil 這兩款終端工具將其轉為 binary plist。相關的教學內容有些不太親民，所以歡迎各位對此有興趣的讀者們另外學習終端機的用法。

### G. 自訂分層分類符號表

該檔案（symbols.dat）可有可無。如果使用者自行放置了該檔案的話，則會影響到分層分類符號選單的內容。可能會有人嫌威注音的原廠的分層分類符號選單的內容太多，這時就可以用自訂的方式滿足自己的個人需求。

該檔案的格式採 libChewing 符號表的格式，範例格式如下（取自新酷音輸入法）：
```
…
※
常用符號=，、。．？！；：‧‥﹐﹒˙·‘’“”〝〞‵′〃～＄％＠＆＃＊
左右括號=（）「」〔〕｛｝〈〉『』《》【】﹙﹚﹝﹞﹛﹜
上下括號=︵︶﹁﹂︹︺︷︸︿﹀﹃﹄︽︾︻︼
希臘字母=αβγδεζηθικλμνξοπρστυφχψωΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ
數學符號=＋－×÷＝≠≒∞±√＜＞﹤﹥≦≧∩∪ˇ⊥∠∟⊿㏒㏑∫∮∵∴╳﹢
特殊圖形=↑↓←→↖↗↙↘㊣◎○●⊕⊙○●△▲☆★◇◆□■▽▼§￥〒￠￡※♀♂
Unicode=♨☀☁☂☃♠♥♣♦♩♪♫♬☺☻
單線框=├─┼┴┬┤┌┐╞═╪╡│▕└┘╭╮╰╯
雙線框=╔╦╗╠═╬╣╓╥╖╒╤╕║╚╩╝╟╫╢╙╨╜╞╪╡╘╧╛
填色方塊=＿ˍ▁▂▃▄▅▆▇█▏▎▍▌▋▊▉◢◣◥◤
線段=﹣﹦≡｜∣∥–︱—︳╴¯￣﹉﹊﹍﹎﹋﹌﹏︴∕﹨╱╲／＼
```

$ EOF.