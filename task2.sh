#!/bin/bash

# Get network information
network_info=$(ifconfig)

# Define email details
to_email="farooq.zaidi@nu.edu.pk"
from_email="k214758@nu.edu.pk"
smtp_server="smtp.example.com"
smtp_port="587"
smtp_username="k214758@nu.edu.pk"
smtp_password="password"

# Create email content
subject="Network Information"
body="Network Information:\n\n$network_info"

# Send email
send_email() {
  echo -e "Subject:$subject\n\n$body" | \
  /usr/bin/openssl s_client -starttls smtp -connect "$smtp_server:$smtp_port" -quiet \
  -CApath /etc/ssl/certs -crlf -ign_eof -quiet \
  -auth plain -xoauth2 -crlf -quiet \
  -CApath /etc/ssl/certs -crlf -ign_eof \
  -connect "$smtp_server:$smtp_port" \
  -servername "$smtp_server" \
  -keyexpansi on "auth=plain user=$smtp_username pass=$smtp_password" \
  -tls1_2 -crlf -ign_eof 2>/dev/null
}

# Send email with network information
send_email


