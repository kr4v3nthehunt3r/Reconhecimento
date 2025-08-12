#!/bin/bash

# Verifica se o endereço de rede foi fornecido como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <endereço_de_rede>"
    echo "Exemplo: $0 192.168.98.0"
    exit 1
fi

# Armazena o endereço de rede fornecido
rede=$1

echo "Iniciando ping sweep para a rede $rede/24..."
echo "Hosts ativos:"

# Extrai o prefixo da rede (ex: 192.168.98)
prefixo=$(echo "$rede" | cut -d '.' -f 1-3)

# Laço para iterar de 1 a 254 e executar os pings em paralelo
for ip in $(seq 1 254); do
    ping -c 1 -W 1 "$prefixo.$ip" | grep "bytes from" | cut -d ' ' -f 4 &
done
wait

echo "Ping sweep concluído."
