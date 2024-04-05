#!/usr/bin/env bash
source <(curl https://raw.githubusercontent.com/wreper12/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
 _     _ _             ______ _           _            
| |   (_) |            | ___ \ |         | |           
| |    _| |__  _ __ ___| |_/ / |__   ___ | |_ ___  ___ 
| |   | | '_ \| '__/ _ \  __/| '_ \ / _ \| __/ _ \/ __|
| |___| | |_) | | |  __/ |   | | | | (_) | || (_) \__ \
\_____/_|_.__/|_|  \___\_|   |_| |_|\___/ \__\___/|___/
                                                       
                                                       
EOF
}
header_info
echo -e "Loading..."
APP="LibrePhotos"
var_disk="24"
var_cpu="2"
var_ram="4096"
var_os="ubuntu"
var_version="22.04"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /root/librephotos-docker ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
if (( $(df /boot | awk 'NR==2{gsub("%","",$5); print $5}') > 80 )); then
  read -r -p "Warning: Storage is dangerously low, continue anyway? <y/N> " prompt
  [[ ${prompt,,} =~ ^(y|yes)$ ]] || exit
fi

cd
cd librephotos-docker

msg_info "Stopping LibrePhotos"
    docker compose down
msg_info "Stopped LibrePhotos"

msg_info "Updating LibrePhotos"
    docker compose pull
msg_info "Updated LibrePhotos"

msg_info "Starting LibrePhotos"
    sudo docker compose up -d
msg_info "Started LibrePhotos"

exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} Setup should be reachable by going to the following URL.
         ${BL}http://${IP}:3000${CL} \n"
