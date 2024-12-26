#!/bin/bash

# Função ajuda
function show_help {
  echo "Uso: $0 [OPÇÕES]"
  echo "  -u URL                  Endereço do servidor (padrão: http://localhost)"
  echo "  -p PORTA                Porta do servidor (padrão: 80)"
  echo "  -d DIRETORIO_DE_LOGS    Diretório onde os logs serão salvos (padrão: ~/nginx-project-logs)"
  echo "  -t TIMEOUT              Tempo limite em segundos para a conexão (padrão: 10)"
  echo "  -h                      Exibe esta ajuda"
}

# Valores padrões
SERVER_URL="http://localhost"
SERVER_PORT="80"
LOG_DIR="$HOME/nginx-project-logs"
TIMEOUT=10

# Processamento dos argumentos
while getopts "u:p:d:t:h" opt; do
  case "$opt" in
    u) SERVER_URL="$OPTARG" ;;
    p) SERVER_PORT="$OPTARG" ;;
    d) LOG_DIR="$OPTARG" ;;
    t) TIMEOUT="$OPTARG" ;;
    h) show_help; exit 0 ;;
    *) show_help; exit 1 ;;
  esac
done

# Criação do diretório de logs, se necessário
mkdir -p "$LOG_DIR"

# Data e hora atual
DATETIME=$(date "+%d-%m-%Y %H:%M:%S")

# Verifica a conectividade com o servidor
if curl --connect-timeout $TIMEOUT -s "${SERVER_URL}:${SERVER_PORT}" > /dev/null; then
  echo "[$DATETIME] nginx server did was found running on ${SERVER_URL}:${SERVER_PORT}" >> "$LOG_DIR/found.log"
else
  echo "[$DATETIME] nginx server was not found running on ${SERVER_URL}:${SERVER_PORT}" >> "$LOG_DIR/notFound.log"
fi
