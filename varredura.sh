#!/bin/bash

# Este script verifica portas comuns em uma lista de endereços IP fornecidos.

# Verifica se algum IP foi fornecido como argumento
if [ "$#" -eq 0 ]; then
    echo "Uso: $0 <IP1> [IP2] [IP3] ..."
    echo "Exemplo: $0 192.168.98.2 192.168.98.3 10.0.0.1"
    exit 1
fi

PORTAS_COMUNS="21 22 23 25 53 80 110 139 443 445 3389 8080"

# Loop através de cada IP fornecido como argumento
for IP_ALVO in "$@"; do
    echo "---"
    echo "Iniciando varredura de portas comuns em ${IP_ALVO}..."
    echo "Portas abertas para ${IP_ALVO}:"

    # Itera sobre a lista de portas comuns e faz a varredura
    for porta in ${PORTAS_COMUNS}; do
        # Usa netcat com um tempo limite e redireciona a saída para filtrar
        nc -vz -w 1 "${IP_ALVO}" "${porta}" 2>&1 | grep "succeeded!" &
    done
    
    # Aguarda todos os processos de netcat terminarem antes de continuar
    wait

    echo "Varredura para ${IP_ALVO} concluída."
    echo ""
done

echo "---"
echo "Todas as varreduras foram concluídas."
