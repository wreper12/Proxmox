#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
msg_ok "Installed Dependencies"

msg_info "Installing Docker"
$STD curl -fsSL https://get.docker.com -o get-docker.sh
$STD sudo sh get-docker.sh
msg_ok "Finished installing Docker"

msg_info "Installing LibrePhotos"
$STD git clone https://github.com/LibrePhotos/librephotos-docker.git
$STD cd librephotos-docker
$STD cp librephotos.env .env
$STD docker compose up -d
msg_ok "Finished installing LibrePhotos"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
