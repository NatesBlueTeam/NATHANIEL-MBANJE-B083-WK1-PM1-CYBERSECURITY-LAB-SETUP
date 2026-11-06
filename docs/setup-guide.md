# Setup Guide

Each step includes **why** it is done, not just what to click.

## 0. Prerequisites

- Windows 11 host, 8 GB RAM or more (16 GB used here), 256 GB SSD or more.
- Virtualization (Intel VT-x / AMD-V) enabled. Check in Task Manager > Performance > CPU > Virtualization = Enabled.
- 7-Zip installed (the Kali VM image comes as a `.7z` archive).

**Why:** without hardware virtualization, 64-bit VMs fail to start or run very slowly.

## 1. Install VirtualBox

1. Download the Windows installer from <https://virtualbox.org/wiki/Downloads>.
2. Run it with the default options. Accept the warning that the network connection will briefly reset.

**Why defaults:** the installer adds virtual network adapters that the NAT Network depends on.

## 2. Create the NAT Network

1. `File > Tools > Network` (Ctrl + H) > **NAT Networks** tab > **Create**.
2. Set:
   - Name: `NatNetwork`
   - IPv4 Prefix: `10.0.0.0/24`
   - Enable DHCP: ticked
   - Enable IPv6: unticked
3. Click **Apply**.

**Why:** the NAT Network is a private virtual router. VMs reach each other and the internet, but outsiders cannot reach them. `10.0.0.1` is reserved for the router.

## 3. Download and add Kali

1. Download the **Virtual Machines > VirtualBox** 64-bit image from <https://kali.org/get-kali>.
2. Extract the `.7z` once, into a folder with 30 GB or more free.
3. In VirtualBox: `Machine > Add` (Ctrl + A), select the `.vbox` file.

**Why Add, not New:** the image is an existing VM (`.vbox` config plus `.vdi` disk). New builds an empty VM that expects an installer ISO.

## 4. VM settings (VM powered off)

| Setting | Location | Value |
|---|---|---|
| Network | Settings > Network > Adapter 1 | Attached to: NAT Network, Name: `NatNetwork`, Promiscuous Mode: Allow All |
| Clipboard | Settings > General > Advanced | Bidirectional |
| Drag'n'Drop | Settings > General > Advanced | Bidirectional |
| Shared folder | Settings > Shared Folders | Host Downloads folder, Auto-mount ticked |

**Why Promiscuous Mode = Allow All:** needed later to capture traffic with Wireshark.

## 5. Start Kali and set the static IP

Default login for the pre-built image: `kali` / `kali`.

1. Network icon > **Edit Connections** > Wired connection 1 > IPv4 Settings.
2. Method **Manual**, Address `10.0.0.2`, Netmask `24`, Gateway `10.0.0.1`, DNS `8.8.8.8`.
3. Save, then disconnect and reconnect the connection.

## 6. Apply the DAD fix (VirtualBox 7 + Kali 2026.1 or newer)

```bash
sudo nmcli connection modify "Wired connection 1" ipv4.dad-timeout 0
sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
```

Or run [`scripts/fix-dad-timeout.sh`](../scripts/fix-dad-timeout.sh).

**Why:** Linux runs duplicate address detection when an interface comes up. On the VirtualBox NAT Network that check can stall, so the connection never fully activates. A timeout of 0 skips the wait, and the setting persists across reboots.

## 7. Verify

Run `bash scripts/verify-lab.sh` inside Kali, or follow [verification.md](verification.md).

## 8. Snapshot

1. Shut Kali down cleanly.
2. VirtualBox Manager > Snapshots > **Take** (Ctrl + Shift + T).
3. Name: `My Fresh Kali Linux after installation`.

**Why:** a clean baseline you can restore in seconds after practising.
