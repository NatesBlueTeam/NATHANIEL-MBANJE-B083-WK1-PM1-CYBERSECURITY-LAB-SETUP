# Screenshots

Evidence that each lab requirement was met.

| File | What it shows | Requirement |
|---|---|---|
| [`01_virtualbox_version.png`](01_virtualbox_version.png) | Help > About VirtualBox (7.2.22) | Latest VirtualBox |
| [`02_nat_network.png`](02_nat_network.png) | NAT Networks tab: `NatNetwork`, 10.0.0.0/24, DHCP enabled | NAT Network |
| [`03_kali_network_settings.png`](03_kali_network_settings.png) | Kali Settings > Network > Adapter 1 attached to `NatNetwork` | VM on the NAT Network |
| [`04_clipboard_dragdrop.png`](04_clipboard_dragdrop.png) | Shared Clipboard and Drag'n'Drop set to Bidirectional | Clipboard and drag-and-drop |
| [`05_shared_folders.png`](05_shared_folders.png) | Host Downloads folder shared with Auto-mount | Shared folder |
| [`06_kali_desktop.png`](06_kali_desktop.png) | Kali Linux running as a VM | Kali Linux installed |
| [`07_kali_ipv4_settings.png`](07_kali_ipv4_settings.png) | IPv4 Settings: Manual, 10.0.0.2/24, gateway 10.0.0.1 | Static IP configuration |
| [`08_ip_a.png`](08_ip_a.png) | `ip a` showing `inet 10.0.0.2/24` on `eth0` | Kali IP 10.0.0.2/24 |
| [`09_ping_tests.png`](09_ping_tests.png) | Ping to the gateway and to google.com, 0% packet loss | Full internet access |
| [`10_snapshot.png`](10_snapshot.png) | Snapshots view with the clean baseline | Snapshot |

The troubleshooting steps and error details are written up in [`../docs/troubleshooting.md`](../docs/troubleshooting.md).
