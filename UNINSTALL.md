---
sort: 4
---
# 如何卸除威注音輸入法

該頁面提供的方法理論上適用於所有版本的威注音輸入法。

如果您使用的是 2.2.0 為止的版本的話，要卸除威注音，請在確保當前安裝為完整安裝之後、摁 Option 鍵的同時點擊輸入法選單圖示，此時會在選單內看到「卸除威注音…」。

自威注音輸入法 2.3.0 開始，對**因失誤而安裝到當前使用者目錄之外**的威注音輸入法的卸除，得採取該頁面所示的步驟。<br />
或者，如果你很懂終端操作的話，輸入法的 App Bundle 內也有用以卸除威注音的終端腳本可用。<br />
**這一切都是因為 macOS 內建的 App Sandbox 機制在預設的情況下不允許符合該機制的應用程式自己刪除自己**，才會這樣麻煩。<br />
威注音輸入法雖已用 Sandbox 例外特性來允許其刪除自身，但僅限威注音輸入法被正確安裝（安裝到使用者目錄之內）之情形。<br />
如果您看不懂本文瑣示之操作的話，請持該網頁[向 Apple Support 尋求人工幫助](https://support.apple.com/zh-tw)、讓他們的專員幫您移除威注音。

> 為什麼要啟用 Sandbox 呢？這是**為了徹底粉碎某些「有損威注音輸入法程式清譽」的謠言**。威注音輸入法從第一版開始就是極度尊重使用者私隱的，為此甚至都不預設啟用自動版本更新檢查。威注音輸入法的 Shift 中英文開關也不會用到系統全局鍵盤事件監聽。各位只需要相信這一個事實就可以了：「**自 macOS 10.15 開始，是可以用 NSEvent 來判定 Shift 是否有摁過的**」。

## 我該手動移除哪些檔案？

先備註，總之你看不懂的話找 Apple Support 就沒錯：

1. 下述所有檔案路徑當中，如果有以「`~/`」開頭的，請將「`~/`」取代為「`/Users/使用者資料夾名稱/`」。
2. 以 `rm -rf` 開頭的行表示「砍掉資料夾」；除此以外以 `rm` 開頭的行表示「砍掉檔案」。
3. 以 `sudo` 開頭的行表示需要管理員權限才能刪除的檔案或資料夾。
4. 「`*`」表示萬用批配字元，代指任何符合該命名條件的檔案。
5. 為了與終端機相容，所有在目錄路徑當中出現的空格都會以「`\`」開頭。

接下來列舉要砍掉的內容。

1. 安裝到正確位置的輸入法主程式：
	```sh
	rm -rf ~/Library/Input\ Methods/vChewing.app
	rm -rf ~/Library/Keyboard\ Layouts/vChewingKeyLayout.bundle
	rm ~/Library/Keyboard\ Layouts/vChewing\ MiTAC.keylayout
	rm ~/Library/Keyboard\ Layouts/vChewing\ IBM.keylayout
	rm ~/Library/Keyboard\ Layouts/vChewing\ FakeSeigyou.keylayout
	rm ~/Library/Keyboard\ Layouts/vChewing\ ETen.keylayout
	rm ~/Library/Keyboard\ Layouts/vChewing\ Dachen.keylayout
	rm ~/Library/Receipts/org.atelierInmu.vChewing.bom
	rm ~/Library/Receipts/org.atelierInmu.vChewing.plist
	```

2. 截至 2.2.x 版為止原廠預設的使用者辭典目錄，請自行決定是否移除：
	```sh
	rm -rf ~/Library/Application\ Support/vChewing/
	```

3. 自威注音 2.3.0 版開始的使用者辭典目錄，請自行決定是否移除。<br />其實你也可以直接移除下文「4.」當中所示的容器。
	```sh
	rm -rf ~/Library/Containers/org.atelierInmu.inputmethod.vChewing/Data/Library/Application\ Support/vChewing/
	rm ~/Library/Containers/org.atelierInmu.inputmethod.vChewing/Data/Library/Application\ Support/vChewing_*.dat
	## 註：dat 檔案為使用者半衰記憶模組檔案。
	``` 

4. 自威注音 2.3.0 版開始的原廠預設的資料容器，其中包含使用者辭典目錄，請自行決定是否移除：
	```sh
	rm -rf ~/Library/Containers/org.atelierInmu.inputmethod.vChewing/
	## 註：該資料夾的名稱在 Finder (訪達) 當中會顯示為「威注音」或「vChewing」。
	``` 

5. 輸入法偏好設定檔案：
	```sh
	rm -rf ~/Library/Preferences/org.atelierInmu.inputmethod.vChewing.plist
	# 如果您有使用過早於威注音 1.2.0 的威注音內部測試版本的話，對應的輸入法偏好設定檔案：
	rm -rf ~/Library/Preferences/org.openvanilla.inputmethod.vChewing.plist
	```

6. 如果輸入法因為 macOS 10.x - macOS 11.x 的安裝程式的 bug 而沒能被正確安裝的話，您還需要清理下述檔案：
	```sh
	sudo rm -rf /Library/Input\ Methods/vChewing.app
	sudo rm -rf /Library/Keyboard\ Layouts/vChewingKeyLayout.bundle
	sudo rm -rf /Library/Keyboard\ Layouts/vChewing\ MiTAC.keylayout
	sudo rm -rf /Library/Keyboard\ Layouts/vChewing\ IBM.keylayout
	sudo rm -rf /Library/Keyboard\ Layouts/vChewing\ FakeSeigyou.keylayout
	sudo rm -rf /Library/Keyboard\ Layouts/vChewing\ ETen.keylayout
	sudo rm -rf /Library/Keyboard\ Layouts/vChewing\ Dachen.keylayout
	sudo rm -rf /Library/Receipts/org.atelierInmu.vChewing.bom
	sudo rm -rf /Library/Receipts/org.atelierInmu.vChewing.plist
	```

以上。

$ EOF.