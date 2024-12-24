#!/bin/bash

check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Esse script precisa ser executado como root ou com sudo."
    exit 1
  fi
}

install_requirements() {
  apt update
  apt upgrade -y
  
  echo "Instalando Nginx..."
  apt install -y nginx

  systemctl start nginx
  systemctl enable nginx

  echo "Instalação do Nginx completa!."

  echo "Instalando git..."

  apt install -y git
  echo "Instalação do git completa!"  
}

setup_cronjob() {
  echo "Configurando Cron Job..."

  SCRIPT_PATH="$(dirname "$(realpath "$0")")/compass-devsecops-scholarship"
  CRON_JOB="*/5 * * * * $SCRIPT_PATH -d $SCRIPT_PATH/logs"

  if crontab -l | grep -F -q "$SCRIPT_PATH"; then
    echo "Cron job já existe..."
  else
    (sudo -u $(logname) crontab -l; echo "$CRON_JOB") | sudo -u $(logname) crontab -
    echo "Cron job foi criado com sucesso!"
  fi
}

check_root
install_nginx
git clone https://github.com/Pl1z3r/compass-devsecops-scholarship.git
setup_cronjob

echo "done..."

