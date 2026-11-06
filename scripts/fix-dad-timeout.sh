#!/usr/bin/env bash
# Fix for no network on VirtualBox 7 + Kali 2026.1 or newer.
#
# Linux runs duplicate address detection (DAD) when an interface comes up.
# On the VirtualBox NAT Network this check can stall, so the connection never
# fully activates. Setting the DAD timeout to 0 skips the wait.
#
# Usage: bash fix-dad-timeout.sh ["Connection name"]
# Default connection name: "Wired connection 1"

set -euo pipefail

CONN="${1:-Wired connection 1}"

echo "[*] Setting ipv4.dad-timeout 0 on: ${CONN}"
sudo nmcli connection modify "${CONN}" ipv4.dad-timeout 0

echo "[*] Restarting the connection"
sudo nmcli connection down "${CONN}"
sudo nmcli connection up "${CONN}"

echo "[+] Done. Current address:"
ip -4 addr show eth0 | grep inet || echo "[!] No IPv4 address on eth0, check the connection name with: nmcli connection show"
