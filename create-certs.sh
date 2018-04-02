#!/usr/bin/env bash
# see: https://coreos.com/os/docs/latest/generate-self-signed-certificates.html

cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server.json | cfssljson -bare server
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client.json | cfssljson -bare client
rm *.csr

# rename client cert files to what docker expects:
mv client.pem cert.pem
mv client-key.pem key.pem


