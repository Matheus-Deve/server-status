#!/bin/bash
cd /root/guarda-service/ || exit 1
./lista_servicos.sh | ./verifica_status.sh | ./export.sh
