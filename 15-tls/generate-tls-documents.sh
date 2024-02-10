#!/bin/bash

# Generate all documents for making TLS communication between:
#    - a Redis client and a Redis server 
#    - a Redis replica and a Redis master

OUTPUT_DIR=./tlsconfig

rm -rf ${OUTPUT_DIR}
mkdir -p ${OUTPUT_DIR}


# Create the Root CA public/private key
# Length must be the longest possible (4094 for RSA)
openssl genrsa -out ${OUTPUT_DIR}/ca.key 4096

# Create the self signed certificate for Root CA
# -req: Create a certificate or CSR
# -x509: Create the certificate and not the CSR
# -new: Create a new certificate request (without writing the file)
# -sha256: sign the certificate with SHA256
# -key: Give the private key to sign the certificate
# -subj: Content of the certificate
# -out: Filename to output the self signed certificate
openssl req \
    -x509 \
    -new \
    -sha256 \
    -key ${OUTPUT_DIR}/ca.key \
    -days 3650 \
    -subj '/O=Redis Test/CN=Certificate Authority' \
    -out ${OUTPUT_DIR}/ca.crt


generate_cert() {
    local name=$1

    local keyfile=${OUTPUT_DIR}/${name}.key
    local certfile=${OUTPUT_DIR}/${name}.crt

    # Generate the pair private/public key (2048 is the recommanded value)
    # Most TLS libraries will recommand or even impose this 2048 value.
    openssl genrsa -out $keyfile 2048
    openssl req \
        -new -sha256 \
        -subj "/O=Redis Test/CN=Generic-cert" \
        -key $keyfile | \
        openssl x509 \
            -req -sha256 \
            -CA ${OUTPUT_DIR}/ca.crt \
            -CAkey ${OUTPUT_DIR}/ca.key \
            -days 365 \
            -out $certfile
}

generate_cert client
generate_cert server
generate_cert replica