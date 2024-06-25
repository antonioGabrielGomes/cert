#!/bin/bash

# Gerar chave privada da CA
openssl genpkey -algorithm RSA -out ca.key -aes256
echo "Chave privada da CA gerada: ca.key"

# Gerar certificado da CA
openssl req -new -x509 -key ca.key -sha256 -out ca.crt -days 3650
echo "Certificado da CA gerado: ca.crt"

# Gerar chave privada do cliente
openssl genpkey -algorithm RSA -out client.key -aes256
echo "Chave privada do cliente gerada: client.key"

# Gerar CSR do cliente
openssl req -new -key client.key -out client.csr
echo "Solicitação de assinatura de certificado do cliente gerada: client.csr"

# Assinar certificado do cliente com a CA
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365 -sha256
echo "Certificado do cliente assinado: client.crt"
