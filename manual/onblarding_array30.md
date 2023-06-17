---
parent: 使用手冊
sort: 73
has_toc: true
---
# 寫給行列三十輸入法的使用者

威注音輸入法自 v3.5.0 版開始升級 CIN2 標準支援至 v2.1 版，提供了對諸如行列輸入法在內的某些輸入法的簡碼輸入支援。這需要 CIN 表格內有實作 `%quick` 章節。如果該章節內有專門用來代表無效候選字的指定特殊字元的話，該 CIN 表格還得實作 `%nullcandidate` 這一行。

針對威注音輸入法專用的行列三十輸入法的 CIN2 磁帶會擇日於 https://github.com/Gontera/array30/ 提供。您屆時可以使用威注音輸入法的磁帶模式載入表格。之後，只需要啟動磁帶模式，就可以正常打字。這個模式的使用體驗與 OpenVanilla 的差異請洽《[寫給 OpenVanilla 的使用者](./onboarding_ov.md)》一文。
