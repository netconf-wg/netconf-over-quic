echo "Generating tree diagrams..."

# ietf-netconf-quic
# augment
pyang -f tree --tree-line-length 69 --tree-print-groupings \
      --tree-no-expand-uses -p .. ../ietf-netconf-quic@*.yang \
      | grep -B 2 -A 2 quic-initiate > tree-ietf-netconf-quic-client-augment.txt
# augment
pyang -f tree --tree-line-length 69 --tree-print-groupings \
      --tree-no-expand-uses -p .. ../ietf-netconf-quic@*.yang \
      | grep -B 2 -A 2 quic-listen > tree-ietf-netconf-quic-server-augment.txt
