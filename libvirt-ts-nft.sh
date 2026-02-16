#!/bin/bash

nft list chain ip libvirt_network guest_input | grep -q 'iif "tailscale0" oif "daddybr0" accept' \
  || nft insert rule ip libvirt_network guest_input position 0 iif "tailscale0" oif "daddybr0" accept

nft list chain ip libvirt_network guest_output | grep -q 'iif "daddybr0" oif "tailscale0" accept' \
  || nft insert rule ip libvirt_network guest_output position 0 iif "daddybr0" oif "tailscale0" accept
