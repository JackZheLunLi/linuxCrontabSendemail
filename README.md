# Gmail 發送郵件腳本

這是一個使用 **Gmail SMTP Server** 搭配 `curl` 發送郵件的 Shell Script。  
支援 **郵件標題 (Subject)**、**郵件內容 (Content)**，並可選擇性附加檔案 (Attachment)。  
同時可透過 `cron` 設定 **定時發送郵件**。

---

## 📌 功能特色
- 使用 Gmail App Password 驗證（安全性高，無需輸入真實密碼）
- 支援純文字郵件
- 支援郵件標題 (Subject)
- 支援附件發送 (Attachment)
- 可搭配 `cron` 設定自動寄送
1. 開啟 crontab
crontab -e

2. 加入排程（例如每天早上 9 點寄送提醒）
0 9 * * * /home/username/send_email.sh "你的gmail@gmail.com" "應用程式密碼" "收件人@gmail.com" "早安提醒

---
## 實作
### 1 創建 Google 應用程式密碼
1. 打開 Google 帳戶
2. 點選安全項目
3. 在「您如何登入 Google」下，選擇兩步驟驗證。
4. 在頁面底部，選擇應用程式密碼。
5. 輸入名稱，方便記住會在哪些情況下使用該應用程式密碼。
6. 選取「產生」。
<img width="1323" height="1018" alt="image" src="https://github.com/user-attachments/assets/ecd34cb0-e955-4567-9f73-84aadf3112c9" />

### 2 撰寫 Bash 腳本
curl 使用 APP_PASSWORD登入 Google SMTP Server 並發送 CONTENT 文字的 Email 給 TO_EMAIL 的 email 信箱。
<img width="1228" height="587" alt="image" src="https://github.com/user-attachments/assets/3e7bca16-d014-4366-934e-2173236b9758" />

### 3 使用 Crontab
1. 首先把剛剛寫好的 send_email.sh 存在 home 底下。
2. 在使用 chmod +x ./send_email.sh 新增執行權限。
3. 在使用 crontab -e 進入 Crontab 檔案編輯。 每天早上 7 點整使用 send_email 腳本發送一則內容為 Hi 的 email 給 xigua@xigua.tw 。07代表每天早上七點，~/send_email.sh youself@gmail.com************** xigua@xigua.tw代表發送的信箱，Hi代表所發送的訊息。
<img width="835" height="25" alt="image" src="https://github.com/user-attachments/assets/3db01e18-51da-4030-81a2-2ef2a8e92641" />

### 4 成果
<img width="591" height="415" alt="image" src="https://github.com/user-attachments/assets/c15f3705-6350-4061-b92c-4756532bffeb" />
