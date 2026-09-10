---
parent: 常見問題
sort: 3
has_toc: true
---
# 技術問答

### 問：唯音的 Sandbox 沙箱機制是？


敝輸入法一向遵循 InputMethodKit 協議、僅處理藉由該協議獲得的鍵盤擊鍵事件。但為了應對「有心人士蠱惑人心、散播與威注音在程式行為道德方面有關的不實謠言」，唯音輸入法有啟用 Apple 的沙箱處理、作為形式上的進一步自我約束、藉以粉碎任何同質謊言。

不過唯音一開始就視使用者私隱為第一位，所以實際上也沒有差。

沙箱特性確實帶來了一些功能特性限制：

1. 使用者片語辭典目錄從此開始只能在使用者目錄範圍內。超出範圍的話會被沙箱困住、而自動改回輸入法原廠預設的使用者片語辭典目錄目錄、或上一次成功可用的目錄。
2. 輸入法無法自己卸除自己。卸除方法請參見：《[如何卸除唯音輸入法](https://vchewing.github.io/UNINSTALL.html)》。
3. 在自訂使用者片語辭典目錄時的資料夾瀏覽視窗內，無法再就地新增資料夾。此為 macOS 沙箱所限制。如果有這種需求的話，請藉由 Finder 等其它手段事先建立好辭典資料夾。
4. 輸入法原廠預設的使用者片語辭典目錄目錄變更為「`~/Library/Containers/org.atelierInmu.inputmethod.vChewing/Data/Library/Application Support/vChewing/`」。之前的預設目錄是「`~/Library/Application Support/vChewing/`」。這是 Apple 的沙箱特性強制要求的變更。請在升級輸入法之前注意備份使用者片語資料。

### 問：為什麼僅支援 Mac？


因為 Swift 語言在其它平台上的研發維護成本太大。目前開發者在編寫下一代輸入法引擎，至少可以移植給 Linux。至於 Windows 還得繼續觀望。

### 問：哪裡可以取得原始碼？


請洽本文開頭。

### 問：選字的原理是什麼？


請在敝專案的 Source Code 內參考 Homa 原始碼。選字原理是 DAG-DP。

### 問：為什麼唯音專案的舊名稱「威注音」裡面的產品名稱喜歡用「權」「威」「恨」之類的字？為什麼現在輸入法中文名改名了？


這裡分別解答一下：

- 威注音專案的「威」取自「威而鋼」的「威」。
- 至於「天權星」其實是「Megrez」星宿的中文名之一。該星宿乃璃月七星之首。 // Megrez 組字引擎現已更換為 Homa 護摩引擎。
- 至於「鐵恨」則是源自「齊鐵恨」這位人物的名字。

因為「威注音」這個中文名稱的 SEO 太爛，故更名為唯音輸入法。

### 問：唯音輸入法前身的圖示當中的「ㄋ」是？


威注音的圖示「ㄋ」取自 Komica 糟糕島流行的與劉寶傑有關的梗「[貼ㄋㄟㄋㄟ救寶傑](https://disp.cc/b/Joke/2sZ0)」。

更名為唯音輸入法之後，便棄用了這個設計。

### 問：資料是從哪邊來的？


請參考 vChewing-VanguardLexicon 倉庫內的說明檔案： [GitHub](https://github.com/vChewing/vChewing-VanguardLexicon/) § [Gitee](https://gitee.com/vChewing/vChewing-VanguardLexicon/)。
