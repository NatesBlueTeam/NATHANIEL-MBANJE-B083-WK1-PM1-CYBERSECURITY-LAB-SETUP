#!/usr/bin/env bash
# Verify the Week 1 lab setup from inside Kali.
# Checks: static IP, gateway, DNS + internet, shared folder, DAD setting.
#
# Usage: bash verify-lab.sh

EXPECTED_IP="10.0.0.2/24"
GATEWAY="10.0.0.1"
CONN="Wired connection 1"
SHARE="/media/sf_Downloads"

pass=0
fail=0

check() {
  local name="$1"; shift
  if "$@" >/dev/null 2>&1; then
    echo "[PASS] ${name}"
    pass=$((pass + 1))
  else
    echo "[FAIL] ${name}"
    fail=$((fail + 1))
  fi
}

echo "=== Lab verification: $(date) ==="
echo "Host: $(hostname)"
echo

check "Static IP ${EXPECTED_IP} on eth0"   bash -c "ip -4 addr show eth0 | grep -q 'inet ${EXPECTED_IP}'"
check "Gateway ${GATEWAY} reachable"       ping -c 2 -W 2 "${GATEWAY}"
check "Internet reachable (8.8.8.8)"       ping -c 2 -W 2 8.8.8.8
check "DNS resolves (google.com)"          ping -c 2 -W 3 google.com
check "Shared folder readable (${SHARE})"  ls "${SHARE}"
check "DAD timeout is 0"                   bash -c "[ \"\$(nmcli -g ipv4.dad-timeout connection show '${CONN}')\" = '0' ]"

echo
echo "Passed: ${pass}  Failed: ${fail}"
echo
echo "--- ip a (eth0) ---"
ip -4 addr show eth0

[ "${fail}" -eq 0 ]
