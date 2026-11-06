# Cybersecurity Practice Lab: VirtualBox + Kali Linux

Week 1 | Project Module 1: Practical Lab Environment Setup

A self-contained, isolated virtual lab for cybersecurity practice (blue team, DFIR, ethical hacking), built on a Windows 11 host with VirtualBox and Kali Linux.

## Lab at a glance

| Item | Value |
|---|---|
| Host OS | Windows 11 (16 GB RAM) |
| Hypervisor | Oracle VirtualBox 7.2.22 |
| Guest OS | Kali Linux 2026.3 (pre-built VirtualBox image) |
| Virtual network | NAT Network `NatNetwork`, 10.0.0.0/24, DHCP enabled |
| Kali address | 10.0.0.2/24 (static) |
| Gateway / DNS | 10.0.0.1 / 8.8.8.8 |
| Shared folder | Host `Downloads`, auto-mounted at `/media/sf_Downloads` |
| Clipboard / drag-and-drop | Bidirectional |

## Network design

```
 Windows 11 host  (real network, internet)
        |
   [ VirtualBox ]
        |
   NatNetwork 10.0.0.0/24
     |- 10.0.0.1   virtual router / gateway
     |- 10.0.0.2   Kali Linux (static)
     '- 10.0.0.3+  future lab VMs (DHCP)
```

A NAT Network lets VMs talk to each other and reach the internet, while nothing outside can start a connection into the lab. That containment is why it suits security testing.

## Requirements and status

- [x] VirtualBox as the base (latest version)
- [x] Kali Linux as an attacker VM (latest version)
- [x] NAT Network on 10.0.0.0/24
- [x] Clipboard and drag-and-drop enabled
- [x] Host Downloads folder shared
- [x] Kali IP set to 10.0.0.2/24
- [x] Full internet access from Kali
- [x] Clean snapshot taken: `My Fresh Kali Linux after installation`

## Repository contents

| Path | Purpose |
|---|---|
| [`docs/setup-guide.md`](docs/setup-guide.md) | Step-by-step build instructions with the reasoning behind each step |
| [`docs/troubleshooting.md`](docs/troubleshooting.md) | The five problems met during setup, causes, and fixes |
| [`docs/verification.md`](docs/verification.md) | Checklist proving each requirement is met |
| [`docs/Week1_Lab_Setup_Challenges.docx`](docs/Week1_Lab_Setup_Challenges.docx) | Word report of the challenges |
| [`scripts/fix-dad-timeout.sh`](scripts/fix-dad-timeout.sh) | Fix for the no-network issue on VirtualBox 7 + new Kali |
| [`scripts/verify-lab.sh`](scripts/verify-lab.sh) | Run inside Kali to check IP, gateway, DNS, internet and shared folder |
| [`screenshots/`](screenshots/) | Evidence screenshots (see its README for the list) |

## Quick start

Follow [`docs/setup-guide.md`](docs/setup-guide.md). Once Kali is running, verify the lab from inside the VM:

```bash
bash scripts/verify-lab.sh
```

## Key lessons

1. Read the exact error text; most errors name their own cause.
2. Keep the VirtualBox Extension Pack at exactly the same version as VirtualBox, or leave it out.
3. Use **Remove Only** (not Delete all files) when deregistering a VM.
4. Test connectivity in layers: interface, gateway, DNS, internet.
5. Snapshot a known-good state before practising with risky tools.

## Notes

- Default Kali credentials are public knowledge. This lab is isolated, but never reuse them anywhere real.
- This repository documents my own build and troubleshooting. Course slides are not included.
- Use this lab only on systems you own or have explicit permission to test.

## Author

Nates, BCYSE III, Institute of Accountancy Arusha (IAA). Focus: Digital Forensics and Incident Response (DFIR).

## License

MIT, see [LICENSE](LICENSE).
