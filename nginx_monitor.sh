#!/bin/bash

DATA=$(date +%d/%m/%Y)
HORA=$(date +%H:%M:%S)
BOT_TOKEN=
CHAT_ID=
STATE_FILE="/tmp/server_status.state"

if [ ! -f "$STATE_FILE" ]; then
    echo "false" > "$STATE_FILE"
fi

function verify_nginx_available(){
	systemctl is-active --quiet nginx
	return $?
}

function verify_website(){
	statusCode=$(curl -o /dev/null -s -w "%{http_code}\n" http://localhost/)

	if [ "$statusCode" != "200" ]; then
		return 1  
	else
		return 0 
	fi
}

function send_message_to_telegram(){
	local message="$1"
	curl -s -o /dev/null -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
		-H 'Content-Type: application/json' \
		-d "{\"chat_id\":\"$CHAT_ID\", \"text\":\"$message\"}"
}



while true; do
    

    AVAILABLE=$(cat "$STATE_FILE")

    if verify_nginx_available && verify_website; then
        if [ "$AVAILABLE" == "false" ]; then
            send_message_to_telegram "✅ O servidor está de volta! A página web está funcionando normalmente e disponível para acesso."
            echo "true" > "$STATE_FILE"
        fi
        echo "$DATA $HORA ** Serviço Nginx rodando e página web no ar!" >> /var/log/meu_script.log
    else
        if [ "$AVAILABLE" == "true" ]; then
            send_message_to_telegram "⚠️ Atenção: O servidor está enfrentando problemas e a página web não está disponível no momento. Estamos trabalhando para resolver o mais rápido possível."
            echo "false" > "$STATE_FILE"
        fi
        echo "$DATA $HORA ** Serviço Nginx não está rodando, página web fora do ar!" >> /var/log/meu_script.log
    fi
    sleep 60
done

