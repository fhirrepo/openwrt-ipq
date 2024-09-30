  #!/bin/sh

# build root files/etc/uci-defaults/99_dumbap.sh
# Define the bridge name
BRIDGE_NAME="br-lan"

# Remove WAN and WAN6 interfaces
uci delete network.wan
uci delete network.wan6

# Add the WAN port to the existing bridge
uci add_list network.@device[0].ports="wan"

# Recreate the LAN interface
uci delete network.lan  # Remove existing LAN interface if it exists
uci set network.lan="interface"
uci set network.lan.device="$BRIDGE_NAME"
uci set network.lan.proto="dhcp"

# Delete the WAN section
uci delete dhcp.wan

# Modify the LAN section to ignore DHCP
uci set dhcp.lan.ignore='1'

# Commit the changes
uci changes
uci commit network
uci commit dhcp
exit 0
