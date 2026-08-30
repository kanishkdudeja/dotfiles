# Pop!_OS configuration

This directory contains the legacy Debian/Pop!_OS components. Its installer
checks `/etc/os-release` and refuses to run on Omarchy, other Arch systems, or
macOS.

Install Zsh first on a fresh Pop!_OS machine:

```sh
bash popos/zsh/install.sh
```

Then run the complete Pop!_OS setup from the repository root:

```sh
bash install.sh popos
```

Running `bash install.sh` without a platform argument also detects Pop!_OS.
Optional Debian application scripts remain under `popos/apps/` and are not run
by the default installer because they are not all idempotent. Other component
installers are implementation details and should be run through the guarded
bundle.

The SSH component only creates `~/.ssh` with mode `0700`; it preserves all
existing keys and SSH configuration. macOS-specific OrbStack and `UseKeychain`
configuration is kept under `macos/ssh/` instead.
