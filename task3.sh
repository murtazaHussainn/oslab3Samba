#!/bin/bash

# Install SAMBA server
install_samba() {
  sudo apt update
  sudo apt install samba -y
}

# Configure SAMBA
configure_samba() {
  sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
  sudo bash -c 'cat << EOF > /etc/samba/smb.conf
  [global]
    workgroup = WORKGROUP
    server string = Samba Server %v
    netbios name = ubuntu
    security = user
    map to guest = bad user
    dns proxy = no

  [samba_share]
    comment = Samba shared folder
    path = /path/to/shared/folder
    browseable = yes
    read only = no
    guest ok = yes
    create mask = 0755
  EOF'
  sudo systemctl restart smbd
}

# Install and configure SAMBA
install_and_configure_samba() {
  install_samba
  configure_samba
}

# Execute the installation and configuration
install_and_configure_samba


