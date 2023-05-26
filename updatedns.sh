#!/bin/bash

# Cloudflare zone is the domain itself
CLOUDFLARE_ZONE="your-domain.com"

# DNS record to update
DNS_RECORD="subdomain.your-domain.com"

# Cloudflare API key
API_KEY="your-cloudflare-api-key"

# Cloudflare Email
EMAIL="your-email@your-domain.com"

# Fetch the current public IP
CURRENT_IP=$(curl -s http://checkip.amazonaws.com/)

# Fetch the previous public IP from file
PREVIOUS_IP=$(cat /path/to/ipfile.txt)

if [ "$CURRENT_IP" != "$PREVIOUS_IP" ]; then
    echo "IP has changed from $PREVIOUS_IP to $CURRENT_IP"
    # Fetch the DNS record id
    RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records?name=$DNS_RECORD&type=A" \
        -H "X-Auth-Email: $EMAIL" \
        -H "X-Auth-Key: $API_KEY" \
        -H "Content-Type: application/json" | jq -r .result[0].id)

    # Update the DNS record
    curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/dns_records/$RECORD_ID" \
        -H "X-Auth-Email: $EMAIL" \
        -H "X-Auth-Key: $API_KEY" \
        -H "Content-Type: application/json" \
        --data '{"type":"A","name":"'"$DNS_RECORD"'","content":"'"$CURRENT_IP"'","ttl":1,"proxied":false}' | jq

    echo $CURRENT_IP > /path/to/ipfile.txt
else
    echo "IP has not changed"
fi
