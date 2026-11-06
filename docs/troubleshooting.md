# Troubleshooting Log

Five problems met during the build, in the order they occurred.

## Summary

| # | Symptom | Root cause | Fix |
|---|---|---|---|
| 1 | New VM wizard asks for an ISO | Used Machine > New | Use Machine > Add with the `.vbox` file |
| 2 | "Can't open machine... same UUID" | VM already registered | Check the Machines list; it was already there |
| 3 | "Failed to save settings" (`VERR_PATH_NOT_FOUND`) | Stale entry pointing to a doubled folder path | Remove Only, then re-add the correct `.vbox` |
| 4 | VM aborts: "Driver name clash" (`VERR_PDM_USB_NAME_CLASH`) | Extension Pack 7.2.4 vs VirtualBox 7.2.22 | Uninstall the Extension Pack, restart VirtualBox |
| 5 | Static IP set, no network | DAD stalling on VirtualBox 7 + new Kali | `ipv4.dad-timeout 0` via `nmcli` |

## 1. Wizard asks for an ISO

- **Cause:** `Machine > New` installs an OS from an installer. The Kali download is already a finished VM.
- **Fix:** `Machine > Add` (Ctrl + A) and choose the `.vbox` file.

## 2. Same UUID error

- **Error:** "Trying to open a VM config ... which has the same UUID as an existing virtual machine."
- **Cause:** an earlier Add had succeeded. The message was a warning, not a fault.
- **Fix:** open the Machines view and use the VM already listed.

## 3. Failed to save settings

- **Error detail:** `Runtime error opening '...vbox-tmp' for overwriting VERR_PATH_NOT_FOUND`.
- **Cause:** the archive was extracted more than once, so the folder name was doubled in the registered path. VirtualBox pointed at a location that did not exist.
- **Fix:**
  1. Right-click the VM > **Remove** > **Remove Only** (never "Delete all files", which erases the virtual disk).
  2. Locate the folder that contains both the `.vbox` and the large `.vdi`.
  3. `Ctrl + A` and add that `.vbox` again.

## 4. Driver name clash

- **Error:** "Driver name clash. Another driver with the same name as the one being registered exists (VERR_PDM_USB_NAME_CLASH)". VM state: Aborted.
- **First theory (did not fix it):** disable the VM USB controller. This hit "Invalid settings detected" because the Pointing Device was USB Tablet, which needs USB. Changing it to PS/2 Mouse allowed USB to be disabled, but the error remained.
- **Root cause:** `File > Tools > Extensions` showed Extension Pack **7.2.4**, while `Help > About` showed VirtualBox **7.2.22**. They must match exactly.
- **Fix:** uninstall the Extension Pack, close VirtualBox Manager completely, reopen, start Kali.
- **Lesson:** ruling out a theory and then checking versions is normal troubleshooting.

## 5. No network after setting the static IP

- **Cause:** duplicate address detection (DAD) stalls on the VirtualBox NAT Network with newer Kali, so the connection never fully activates.
- **Fix:**

```bash
sudo nmcli connection modify "Wired connection 1" ipv4.dad-timeout 0
sudo nmcli connection down "Wired connection 1"
sudo nmcli connection up "Wired connection 1"
```

- **Result:** `inet 10.0.0.2/24` on `eth0`, 4/4 replies from `10.0.0.1`, 4/4 replies from `google.com`.
- **Layered test:** pinging the gateway first, then a domain name, separates a network fault from a DNS fault.

## General method

1. Read the exact error and result code.
2. Change one thing at a time and re-test.
3. Prefer reversible, non-destructive actions.
4. Record symptoms, causes, and fixes. This is the same discipline used in incident response.
