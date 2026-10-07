#!/bin/bash
echo "Servico,Status,Dias"
while read -r servico; do
    [ -z "$servico" ] && continue
    status=$(systemctl show "$servico" --property=ActiveState --value)
    data_estado=$(systemctl show "$servico" --property=ActiveEnterTimestamp --value)
    if [ -n "$data_estado" ] && [ "$data_estado" != "n/a" ]; then
        
        segundos_estado=$(date -d "$data_estado" +%s 2>/dev/null)
        segundos_agora=$(date +%s)
        
        if [ -n "$segundos_estado" ]; then
            diferenca=$((segundos_agora - segundos_estado))
            dias=$((diferenca / 86400))
        else
            dias="N/A"
        fi
    else
        dias="N/A"
    fi
    echo "$servico,$status,$dias"
done
