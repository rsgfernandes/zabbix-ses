########################################################### 
# AUTHOR  : Rodrigo Fernandes - https://br.linkedin.com/in/rsgfernandes
# DATE    : 06-05-2015
########################################################### 

#!/bin/bash


# Script parameters
DESTINO="$1"
DE="digite seu e-mail"
ASSUNTO="$2"
MENSAGEM="$3"


# Validate script syntax
[ $# -eq 0 ] && { echo "Usage: $0 e-mail@address.com subject message"; exit 1; }

# Set cURL variables
date="$(date -R)"
access_key="digite sua access key"
secret_key="digite sua secret key"
assinatura="$(echo -n "$date" | openssl dgst -sha256 -hmac "$secret_key" -binary | base64 -w 0)"

# Generates Auth Cert
cabecalho_autenticacao="X-Amzn-Authorization: AWS3-HTTPS AWSAccessKeyId=$access_key, Algorithm=HmacSHA256, signature=$assinatura"

# AWS SES Endpoint - Change it for your prefered region
endpoint="https://email.us-east-1.amazonaws.com/"

# AWS SES Calls
acao_envio="Action=SendEmail"
remetente="Source=$DE"
destinatario="Destination.ToAddresses.member.1=$DESTINO"
assunto="Message.Subject.Data=$ASSUNTO"
corpo_email="Message.Body.Text.Data=$MENSAGEM"

# SES POST
curl -v -X POST -H "Date: $date" -H "$cabecalho_autenticacao" --data-urlencode "$corpo_email" --data-urlencode "$destinatario" --data-urlencode "$remetente" --data-urlencode "$acao_envio" --data-urlencode "$assunto"  "$endpoint"
 
