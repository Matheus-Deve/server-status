#!/bin/bash
ARQUIVO="relatorio_servicos.csv"
cat > "$ARQUIVO"
CAIDOS=$(grep -i "failed" "$ARQUIVO" | wc -l)
PARADOS=$(grep -i "inactive" "$ARQUIVO" | wc -l)
DATA=$(date '+%d/%m/%Y %H:%M:%S')
if [ "$CAIDOS" -gt 0 ]; then
    MENSAGEM="⚠️ ALERTA: $CAIDOS serviço(s) FALHOU! | $DATA"
elif [ "$PARADOS" -gt 0 ]; then
    MENSAGEM="⏸️ AVISO: $PARADOS serviço(s) INATIVO(S) | $DATA"
else
    MENSAGEM="✅ Tudo OK: Serviços rodando normalmente | $DATA"
fi
git add "$ARQUIVO"
if git diff --staged --quiet; then
    echo "Sem alterações no relatório. Commit ignorado."
else
    git commit -m "$MENSAGEM"
    git push origin main
fi
