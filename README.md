# Arch Setup

A repository of scripts and configuration files for setting up my Arch Linux on a new system.

## Use

### Install

install archlinux with the following settings:

  - archinstall language: As you wish
  - locales: leave as is
  - mirrors and repositories: setup based on your location
  - kernels: leave as is
  - hostname: choose whatever you want
  - profile: leave as is
  - applications: leave as is
  - pacman: leave as is
  - additional packages: leave as is
  - automatic time sync: leave as is

  - Disk configuration:
    - Use best effort partitioning, with btrfs(zstd)
    - Skip LVM
    - Encrypt with LUKS
    - Btrfs snapshots: Snapper

  - swap: zram
  - Bootloader: Limine
  - Authentification: create a user with sudo privileges

then run:

```bash
git clone https://github.com/MaelTriquet/arch-setup.git
cd arch-setup
./install.sh
```

Follow the wizard to install.

### Update

To update, run:

```bash
cd arch-setup
./update.sh
```

