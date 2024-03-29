---
parent: 使用手冊
sort: 8
has_toc: true
---
# 鍵盤熱鍵使用手冊（macOS）

本文對應至少威注音 3.7.3。請利用滑鼠滾輪檢視該頁面。

為了簡化下文表述，這裡介紹一下本文會用到的 macOS 的鍵盤符號。

- 註1：BackSpace 與 Delete 採 Windows 稱謂。
- 註2：下表內的四個方向鍵的稱謂，均為根據文字書寫順序方向而言的相對方向稱謂。
- 註3：簡體中文使用者請注意本文「遞交」一詞的意義與「上屏」相同，英文都是「Commit」。
- 註4：威注音不會對數字小鍵盤攔截響應（小鍵盤 Enter 鍵除外），除非有選字窗出現、且有數字小鍵盤內能輸入的字符被設為選字鍵。
- 註5：本文下文出現的所有「數字鍵」均指主鍵盤區域的數字鍵。
- 註6：本文用語「（內文）組字區」代指「inline composition buffer」，在微軟術語體系當中也被稱作「pre-edit area」。
- 註7：本文用語「組音區」是指由鐵恨注拼引擎操縱的注音組音區。組音區會在使用者敲注音時出現在內文組字區內。輸入法自組音區取得讀音，在驗證其具有對應的辭典記錄之後，將其插入至天權星組字引擎。整個內文組字區相當於組字引擎與注拼引擎的統合外在表現。
- 註8：為了保證表達與討論的有效性、減少歧義，本文在討論前後關係時，只用「往前/往後」「前方/後方」，且僅以文字書寫方向為這些用語的方向參照。這與 Zonble 的「Before-After」前後術語邏輯體系不同：威注音在使用英文術語的情況下只用「Front / Rear (Back, Tail)」、「Forward / Backward」。
- 註9：所謂「符號選單狀態」僅代指分類波浪符號選單。

| 符號 | mac 鍵盤 |
|-:|-|
| ⌘ | CMD (Command  / Windows / Super) |
| ⌥ | Alt (Option) |
| ⌃ | Ctrl (Control) |
| ⇧ | Shift |
| ⇪ | Caps (Caps Lock) |
| ⌫ | Bksp (BackSpace，被 Apple 稱為 Delete) |
| ⌦ | Del (這才是真的 Delete) |
| ⎋ | Esc (Escape) |
| ␣ | Space (空格) |
| ⇥ | Tab |
| ⏎ | Return (與 Enter ⌤ 合併處理) |
| ↑ | 左手方向鍵，也就是：橫排書寫時的上方向鍵，縱排書寫時的右方向鍵 |
| ↓ | 右手方向鍵，也就是：橫排書寫時的下方向鍵，縱排書寫時的左方向鍵 |
| ← | 向後方向鍵，也就是：橫排書寫時的左方向鍵，縱排書寫時的上方向鍵 |
| → | 向前方向鍵，也就是：橫排書寫時的右方向鍵，縱排書寫時的下方向鍵 |
| ↖︎ | Home |
| ↘︎ | End |
| ⇞ | PgUp (Page Up) |
| ⇟ | PgDn (Page Down) |
| ☰ | 上下文選單鍵 (僅 PC 鍵盤) |

下述熱鍵用以作為模式切換開關，可在偏好設定內停用：

| 熱鍵 | 模式 |
|-:|-|
| ⌃⇧⌘ P | 模擬逐字選字輸入（就是ㄅ半那樣的輸入方式） |
| ⌃⇧⌘ K | 康熙正體字模式（某些漢字會變成對應的康熙字元） |
| ⌃⇧⌘ A | 逐字選字聯想模式（就是ㄅ半的關聯詞語） |
| ⌃⇧⌘ J | 日文 JIS 新字體模式（方便在日本的網站線上郵購） |
| ⌃⇧⌘ L | 全字庫模式（不另外安裝全字庫字型的話，某些候選字會顯示成方塊） |
| ⌃⇧⌘ H | 半形標點模式（程式蝨專用） |
| ⌃⇧⌘ M | 大寫漢字數字輸出（會將「一二三四五」轉為「壹貳參肆伍」） |
| ⌃⇧⌘ I | CIN 磁帶模式 |

下述熱鍵則為敲字時的基礎功能：

| 熱鍵 | 功能 | 備註 |
|-:|-|-|
| ⏎ | 遞交輸出當前組字區的全部內容。 | 組字區有內容時才會生效；<br />輸入法並非處於標記模式時才會生效。 |
| ⇧⏎ | 將當前組字區內容遞交出去之後、以文字輸入方向最前端的已遞交的節點內容作為索引資料、來試圖叫出關聯詞語選字窗。 | 對逐字選字模式無效，因為組字選字模式另有安排。 |
| ⌥⇧⏎ | 將當前組字區內容以空格做逐字分隔、再遞交出去。 | 組字區有內容時才會生效。 |
| ⌥→<br />⌥← | 令組字區游標向前移動一個詞語節點<br />令組字區游標向後移動一個詞語節點 | 組字區有內容時才會生效。 |
| JIS英數鍵 | 中英文輸入模式切換 | 只有 JIS 日語鍵盤才有這個按鍵。 |
| ⇧↑<br />⇧↓ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 組字區有內容時才會生效。 |
| ⌃⌘]<br />⌃⌘[ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 組字區有內容時才會生效。 |
| ☰<br />⇧☰ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 組字區有內容時才會生效。 |
| ⌥↑<br />⌥↓ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 組字區有內容時才會生效。 |
| ⇧ ␣<br />⇧⌘ ␣ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 同上，但可用左手單手操作：<br />大拇指可以從 ⌘ 掃到 ␣ 上。 |
| ⇥<br />⇧⇥ | 以固定順序就地輪替候選字（下一個候選字）<br />以固定順序就地輪替候選字（上一個候選字）| 同上，可在偏好設定內改為呼叫選字窗。<br />無法用於臉書，因為臉書會攔截 Tab 鍵。 |
| ⌥⌃→<br />⌥⌃← | 迅速將組字區內的游標挪到組字區最前方<br />迅速將組字區內的游標挪到組字區最後方 | 組字區有內容時才會生效。 |
| ↘︎<br />↖︎ | 迅速將組字區內的游標挪到組字區最前方<br />迅速將組字區內的游標挪到組字區最後方 | 同上。 |
| ⇧→<br />⇧← | 控制組字區內的高亮標記選擇範圍，<br />之後可進行被螢幕所提示的操作。 | 組字區有內容時才會生效；<br >當有高亮選擇內容時，輸入法處於標記模式。 |
| ⏎ | 將當前高亮標記了的詞音配對新增至使用者辭典，<br />如果已經是既有詞音配對的話、則會提升其權重。 | 輸入法處於標記模式時才會生效。 |
| ⇧⌘⏎ | 將高亮標記了的當前在庫的詞音配對的權重<br />壓低至 -114.514。 | 輸入法處於標記模式時才會生效；<br />相關記錄存於使用者語彙檔案當中；<br />對使用者關聯詞語無法生效。 |
| ⌫<br />⌦ | 將當前高亮標記了的詞音配對新增至語彙濾除表，<br />輸入法在拿讀音查詢在庫語彙時會忽略相關結果。<br />也就是俗稱的「就地刪詞」。 | 輸入法處於標記模式時才會生效；<br />對使用者關聯詞語無法生效。 |
| ⇧⌦ | 清空當前組字區。 | 輸入法不處於標記模式時才會生效。<br />組字區有內容時才會生效。 |
| ⇧⌫ | 析構掉游標身後的漢字讀音，<br />使其等待新的聲調輸入。 | 輸入法不處於標記模式時才會生效。<br />組字區有內容時才會生效。<br />該行為可在新版偏好設定內修改。 |
| 聲調鍵 | 析構掉游標身後的漢字讀音，<br />且使用聲調鍵的讀音複寫之。<br />若發現不可析構，則直接輸入聲調。 | 輸入法不處於標記模式時才會生效。<br />組字區有內容時才會生效。<br />該行為可在新版偏好設定內修改。 |
| ⌃⌥⌘⏎ | 將當前組字區遞交為網頁 Ruby 讀音標記格式，<br />其拼音 / 注音書寫符合教科書書寫排版規範：<br />也就是拼音標調在字母上、注音先寫輕聲標記。 | 組字區有內容時才會生效；<br />可在偏好設定內設定是輸出注音還是拼音。 |
| ⌃⌘⏎ | 將當前組字區的讀音串單獨遞交輸出，<br />輸出的漢語拼音採 12345 數字標調、<br />輸出的注音的輕聲標記是在注音符號之後才寫的。 | 組字區有內容時才會生效；<br />可在偏好設定內設定是輸出注音還是拼音；<br />讀音以西文半形空格相連。 |
| ⌃⇧⌘⏎ | 將當前組字區的讀音串單獨遞交輸出，<br />輸出的漢語拼音採 12345 數字標調、<br />輸出的注音的輕聲標記是在注音符號之後才寫的。 | 組字區有內容時才會生效；<br />可在偏好設定內設定是輸出注音還是拼音；<br />讀音以西文半形減號相連。 |
| ⇧ ␣ | 在組字區內沒有內容時，輸入全形空格 | 可摁住不放以連續輸入。 |
| 摁住 ⌥⇧<br />敲數字鍵 | 用來輸入全形阿拉伯數字 | 如果目前已經啟用了半形標點模式的話，<br />則該熱鍵會輸入半形阿拉伯數字。 |
| 摁住 ⌥<br />敲數字鍵 | 用來輸入半形阿拉伯數字 |  |
| ～ | 分類波浪符號選單（類似新酷音），<br />可在使用者辭典目錄內寫 symbols.dat 自訂內容。 | JIS 鍵盤注意：<br />得用右 Shift 左側的「_」鍵取代「～」鍵。 |
| ⌥ ～ | 敲一下切換至內碼輸入模式；<br />再敲一下則切換至漢音鍵盤符號模式。 | 可藉由 Enter / Esc / Delete 鍵關閉被這種方式 用的模式。 |
| ⌥⇧ ～ | 不分類的波浪符號選單（內容可自訂） | JIS 鍵盤注意：<br />得用右 Shift 左側的「_」鍵取代「～」鍵。 |
| ⇞<br />⇟ | 呼叫選字窗 | 組字區有內容時才會生效。<br />逐字選字模式會自動跳選字窗。 |
| ␣ | 呼叫選字窗 | 同上，但可在偏好設定內停用。 |
| ⎋ | 非標記模式下，清空整個組字區。<br />標記模式下，退出標記模式。 | 其在非標記模式下的行為可在偏好<br />設定內停用，屆時僅會清空注拼槽。 |
| 右⇧<br />左⇧ | 切換英數輸入模式的開關。 | 左⇧可在偏好設定內停用。 |
| ⌥⌦<br />⌥⌫ | 刪除一個字詞節點。<br />⌥⌫ 會優先刪除尚未完成的讀音/字根。 | 組字區有內容時才會生效；<br />輸入法並非處於標記模式時才會生效。 |

下述熱鍵則為**預設田所選字窗正在顯示（也就是你正在選字）時**可以用的功能：

| 熱鍵 | 功能 | 備註 |
|-:|-|-|
| ⏎ | 確認選字窗內的當前候選字 | 關聯詞語選字時，該功能可在偏好設定內啟用或停用。 |
| ⇧⏎ | 將當前組字區內容遞交出去之後、以當前高亮候選字詞作為索引資料、來試圖叫出關聯詞語選字窗。<br />如果能成功叫出關聯詞語的話，會先遞交當前組字區的內容。 | 關聯詞語僅會在游標處於組字區最前方的時候才可以觸發。<br />對逐字選字模式無效，因為組字選字模式另有安排。 |
| ⌃⌘]<br />⌃⌘[ | 選字窗內選中下一個候選字（正向輪替）<br />選字窗內選中上一個候選字（反向輪替）|  |
| ⇥<br />⇧⇥ | 選字窗內選中下一個候選字（正向輪替）<br />選字窗內選中上一個候選字（反向輪替） | 可以在偏好設定內更改輪替對象為頁，但是有例外：<br />當候選字詞只有一頁時，輪替對象仍為候選字詞本身。 |
| ␣<br />⇧ ␣ | 根據輸入法偏好設定來決定<br />是正向輪替頁面還是候選字詞 | 當候選字詞只有一頁時，輪替對象仍為候選字詞本身。 |
| ⇞<br />⇟ | 翻頁 | 候選字詞只有一頁時，輪替對象為候選字詞本身。 |
| ↖︎<br />↘︎ | 選中第一個候選字<br />選中最後一個候選字 | 多餘的操作會觸發蜂鳴。 |
| ⎋<br />⌫<br />⌦<br />⇧→<br />⇧← | 回退到上一層符號選單、或關掉選字窗 | 不是符號選單狀態的場合，一律關掉選字窗。<br />其中，Esc 按鍵會直接導致 Spotlight 關閉。 |
| 摁住 ⇧<br />敲選字鍵 | 選擇指定的聯想候選詞（會有螢幕提示） | 與奇摩輸入法行為一致。 |
| ⌥→<br />⌥← | 在選字窗顯示時移動組字區內的游標（以字詞節點為單位，逐節移動）。 |  |
| ⇧⌥→<br />⇧⌥← | 在選字窗顯示時移動組字區內的游標（以單個幅長（讀音）為單位，逐幅移動）。 | 如果發現移動後的游標出現了切割字元的情況的話，則會自動將游標繼續移動至當前節點的邊界。 |

$ EOF.
