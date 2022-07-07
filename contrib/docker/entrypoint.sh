#!/usr/bin/env sh

set -e

CONF_DIR="/etc/yggdrasil-network"
CONF="$CONF_DIR/config.conf"

# if [ ! -f $CONF ]; then
  echo "generate $CONF"
  # yggdrasil --genconf -json > "$CONF"
  tmp=$(mktemp)
  jq '.NodeInfo = { "samizdapp": { "groups": ["test", "pleroma"] } }' "$CONF" > "$tmp" && mv "$tmp" "$CONF"
  tmp=$(mktemp)
  jq '.AdminListen = "tcp://localhost:9001"' "$CONF" > "$tmp" && mv "$tmp" "$CONF"
  tmp=$(mktemp)
  jq '.Peers = ["tls://51.38.64.12:28395"]' "$CONF" > "$tmp" && mv "$tmp" "$CONF"
# fi

yggdrasil --useconf -json < "$CONF_DIR/config.conf"
exit $?
