#!/bin/bash
# send_email.sh
# 使用 Gmail SMTP 發送郵件 (支援標題、內容、附件)

# 傳入參數
FROM_EMAIL=$1       # 寄件人 Gmail
APP_PASSWORD=$2     # Gmail App Password
TO_EMAIL=$3         # 收件人
SUBJECT=$4          # 郵件標題
CONTENT=$5          # 郵件內容
ATTACHMENT=$6       # 附件 (可選)

# 建立暫存郵件檔
EMAIL_FILE=$(mktemp)

# 建立郵件格式 (RFC 5322)
{
  echo "From: ${FROM_EMAIL}"
  echo "To: ${TO_EMAIL}"
  echo "Subject: ${SUBJECT}"
  echo "MIME-Version: 1.0"

  if [ -n "$ATTACHMENT" ]; then
    BOUNDARY="ZZ_BOUNDARY_$$"
    echo "Content-Type: multipart/mixed; boundary=$BOUNDARY"
    echo
    echo "--$BOUNDARY"
    echo "Content-Type: text/plain; charset=UTF-8"
    echo
    echo "$CONTENT"
    echo "--$BOUNDARY"
    echo "Content-Type: application/octet-stream; name=\"$(basename $ATTACHMENT)\""
    echo "Content-Transfer-Encoding: base64"
    echo "Content-Disposition: attachment; filename=\"$(basename $ATTACHMENT)\""
    echo
    base64 "$ATTACHMENT"
    echo "--$BOUNDARY--"
  else
    echo "Content-Type: text/plain; charset=UTF-8"
    echo
    echo "$CONTENT"
  fi
} > "$EMAIL_FILE"

# 使用 curl 發送
curl --ssl-reqd \
     --url 'smtps://smtp.gmail.com:465' \
     --user "$FROM_EMAIL:$APP_PASSWORD" \
     --mail-from "$FROM_EMAIL" \
     --mail-rcpt "$TO_EMAIL" \
     --upload-file "$EMAIL_FILE"

# 刪除暫存檔
rm -f "$EMAIL_FILE"
