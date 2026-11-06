# Verification Checklist

Run inside Kali unless stated otherwise. Take a screenshot of each result (see [`../screenshots/README.md`](../screenshots/README.md)).

| # | Requirement | Check | Expected result |
|---|---|---|---|
| 1 | VirtualBox latest | Host: Help > About VirtualBox | 7.2.22 |
| 2 | NAT Network | Host: File > Tools > Network > NAT Networks | `NatNetwork`, 10.0.0.0/24, DHCP enabled |
| 3 | Adapter | Host: Kali > Settings > Network | NAT Network / `NatNetwork` |
| 4 | Clipboard, drag-and-drop | Host: Kali > Settings > General > Advanced | Bidirectional |
| 5 | Shared folder | Host: Kali > Settings > Shared Folders | Downloads, Auto-mount = Yes |
| 6 | Static IP | `ip a` | `inet 10.0.0.2/24` on `eth0` |
| 7 | Gateway | `ping -c 4 10.0.0.1` | 0% packet loss |
| 8 | DNS and internet | `ping -c 4 google.com` | 0% packet loss |
| 9 | Shared folder works | `ls /media/sf_Downloads` | Host download files listed |
| 10 | DAD fix persisted | `nmcli -g ipv4.dad-timeout connection show "Wired connection 1"` | `0` |
| 11 | Snapshot | Host: Snapshots tab | `My Fresh Kali Linux after installation` |

Items 6 to 10 can be checked in one go:

```bash
bash scripts/verify-lab.sh
```

## If shared folder access is denied

```bash
sudo usermod -aG vboxsf kali
```

Then reboot Kali and try again.
