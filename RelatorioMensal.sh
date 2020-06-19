#!/usr/bin/env bash
#-----------HEADER-------------------------------------------------------------|
# AUTOR             : Matheus Martins 3mhenrique@gmail.com
# HOMEPAGE          : https://github.com/mateuscomh 
# DATA CRIAÇÃO   : 
# PROGRAMA          : Shell-Base
# VERSÃO            : 1.0.0
# LICENÇA           : GPL3
# PEQUENA-DESCRIÇÃO : Programa para gerar relatório de uso de interface
#
# CHANGELOG :
#
#------------------------------------------------------------------------------

#-------------------------------VARIAVEIS------------------------------------->
#------------------------------FIM-VARIAVEIS----------------------------------<

#--------------------------------FUNCOES-------------------------------------->
trap desligasistema 1 2 3 4 5 6 9 15

desligasistema() {

interface="enp0s25"

base_mb="1048576"

dados_rede_diario="/scripts/Output/rede_diario.txt"
down_total="/scripts/Output/download"
up_total="/scripts/Output/upload"

tx=$(cat /sys/class/net/$interface/statistics/tx_bytes)
rx=$(cat /sys/class/net/$interface/statistics/rx_bytes)

download="0"
upload="0"
tot_download=$(cat /scripts/Output/download)
tot_upload=$(cat /scripts/Output/upload)
    data_relatorio=$(date '+%d/%m/%Y %R:%S')
        upload=$(echo "scale=2; $tx/$base_mb" | bc)
        download=$(echo "scale=2; $rx/$base_mb" | bc)

        echo "$download+$tot_download" | bc > $down_total
        echo "$upload+$tot_upload" | bc > $up_total
        echo "$data_relatorio Download $download MiB || Upload $upload MiB" >> $dados_rede_diario
        echo "$data_relatorio Download Total $tot_download MiB || Upload Total $tot_upload MiB" >> $dados_rede_diario
        exit 0 
}
#-------------------------------FIM-FUNCOES-----------------------------------<
while : 
do
  sleep 10000
done
exit 0
