#!/bin/bash
#  generate-client - Create client key-pair for MQTT signed by CA
#
#  The key is not encrypted so that the certificate can be used on
#  embedded devices.

# Copyright 2015 Jerry Dunmire <jedunmire-AT-gmail>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of mosquitto nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

#
# Usage:
#   ./generate-client.sh client_name
#     creates client_name{key,crt}
set -e

if [ -n "$1" ]; then
    client="$1"
else
   echo "ERROR: missing client_name argument." >&2
   echo "USAGE: $0 client_name" >&2
   echo "exiting... " >&2
   exit 1
fi

[ -z "$USER" ] && USER=root

DIR=${TARGET:='.'}
# CA_ORG set to match generate-CA.sh
CA_ORG='/O=MQTTitude.org/emailAddress=nobody@example.net'
CACERT=${DIR}/ca
CLIENT="${DIR}/${client}"
CLIENT_DN="/CN=${client}$CA_ORG"
keybits=2048
openssl=$(which openssl)

function maxdays() {
    nowyear=$(date +%Y)
    years=$(expr 2032 - $nowyear)
    days=$(expr $years '*' 365)

    echo $days
}

days=$(maxdays)

if [ ! -f $CACERT.crt ]
then
    echo "ERROR: Could not find CA certificate: $CACERT.crt" >&2
    echo "Exiting..." >&2
    exit 1
fi

if [ ! -f $CLIENT.key ]
then
    echo "--- Creating client key and signing request"
    echo "--- WARNING: key is not encrypted, keep it safe!"
    $openssl genrsa -out $CLIENT.key $keybits
    $openssl req -new \
        -out $CLIENT.csr \
        -key $CLIENT.key \
        -subj "${CLIENT_DN}"
    chmod 400 $CLIENT.key
fi

if [ -f $CLIENT.csr -a ! -f $CLIENT.crt ]
then
    echo "--- Creating and signing client certificate"
    $openssl x509 -req \
        -in $CLIENT.csr \
        -CA $CACERT.crt \
        -CAkey $CACERT.key \
        -CAserial "${DIR}/ca.srl" \
        -out $CLIENT.crt \
        -days $days \
        -addtrust clientAuth

    chmod 444 $CLIENT.crt
fi
