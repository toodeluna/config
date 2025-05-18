<div align="center">

# Config

![Blahaj Go Spin](./assets/gifs/blahaj.gif)

[![NixOS Unstable](https://img.shields.io/badge/nixos-unstable-blue?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
![GitHub repo size](https://img.shields.io/github/repo-size/toodeluna/config?style=for-the-badge&logo=github&logoColor=orange&color=orange)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/toodeluna/config/check.yml?style=for-the-badge)

</div>

## Table of Contents

- [Config](#config)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Structure](#structure)
    - [Repository](#repository)
    - [Configurations](#configurations)
    - [Modules](#modules)
  - [Installation](#installation)
  - [Further Reading](#further-reading)
    - [Other People's Configurations](#other-peoples-configurations)
    - [Interesting Websites](#interesting-websites)
    - [YouTube](#youtube)

## Introduction

Hello, dear reader. It seems you've stumbled upon my Nix system configuration repository. This flake is a way for me to
have all my configuration be as declarative as possible. Since it's mostly tailored to my own use cases, I wouldn't
recommend using the flake for your own system, but it could serve as an inspiration for your own Nix configuration.

I will do my best to document this project as clearly as possible so that it's easy to understand how it works for
anyone reading this and for future me who might forget how parts of this work because they are very stupid :3.

## Structure

### Repository

- [assets/](./assets/): Assets (mostly images) that are used throughout the project.
- [configurations/](./configurations/): The actual system configurations.
- [constants/](./constants/): Constants that are passed to the configurations and modules.
- [modules/](./modules/): Modules for NixOS, Nix Darwin and Home Manager.
- [secrets/](./secrets/): Age encrypted secrets that can be used by the configurations.
- [flake.nix](./flake.nix): The flake entry point.

### Configurations

- [crona](./configurations/crona/): My desktop that I use for gaming and personal projects.
- [excalibur](./configurations/excalibur/): My MacBook that I use for work.

### Modules

- [common](./modules/common/): Modules used by both NixOS and Nix Darwin.
- [nixos](./modules/nixos/): Modules for NixOS.
- [darwin](./modules/darwin/): Modules for Nix Darwin.
- [home/common](./modules/home/common/): Home manager modules for NixOS and Nix Darwin.
- [home/nixos](./modules/home/nixos/): Home manager modules for NixOS.

## Installation

In order to install the configuration on a new system a few steps must be taken, mainly due to
the fact the configuration uses Age encrypted secrets that the system must first be given access
to. It's a bit of a chicken-and-egg-problem since you already need a system with the configuration
on it in order to install it on a separate system. I might look for ways to improve this in the
future, but it's fine for now because again: this is pretty much only made for my own use.

To start of: make sure you have a system with NixOS or Nix Darwin installed on it. Then generate an
SSH key-pair on this system. Then, on the machine that already has the configuration on it, open
the [constants/ssh-keys.nix](./constants/ssh-keys.nix) file and add the new machine's public key
to it like so:

```nix
{
  newMachine = {
    root = "<root_public_ssh_key>";
    user = "<user_public_ssh_key>";
  };
}
```

Then `cd` into the [secrets](./secrets/) directory and give the new machine access to the secrets
that it needs to set up the system by adding it to the [secrets.nix](./secrets/secrets.nix) file.
Then use the agenix command line tool to rekey the secrets.

```sh
$ agenix -r
```

After that you can add a new configuration to the [configurations](./configurations/) directory
and add it to the [hosts.nix](./modules/flake/hosts.nix) file. Make sure to push all these changes
to GitHub.

Then, on the target system, clone this repository, ideally into your home directory under
`github/toodeluna/config` on Linux or `GitHub/toodeluna/config` on MacOS. Then `cd` into it
and run the following command:

```sh
# On NixOS:
$ sudo nixos-rebuild switch --flake .

# On MacOS:
$ darwin-rebuild switch --flake .
```

## Further Reading

### Other People's Configurations

Some repos that I've taken inspiration from when writing this one:

- [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
- [zoriya/flake](https://github.com/zoriya/flake)
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [namishh/crystal](https://github.com/namishh/crystal)
- [LunaPresent/dotfiles](https://github.com/LunaPresent/dotfiles)
- [ceselder/dotfiles](https://github.com/ceselder/dotfiles)

### Interesting Websites

Websites, blogs and articles related to Nix that are worth checking out as well:

- [mynixos.com](https://mynixos.com/)
- [isabelroses.com](https://isabelroses.com/)
- [namishh.me](https://namishh.me/)

### YouTube

YouTube channels and videos related to Nix that you should definitely check out:

- [Vimjoyer](https://www.youtube.com/@vimjoyer): Probably the best Nix tutorial channel on YouTube.
- [Nix Explained From The Ground Up](https://www.youtube.com/watch?v=5D3nUU1OVx8): The best explanation of how Nix works as a whole.
- [Nix is My Favorite Package Manager to Use On MacOS](https://www.youtube.com/watch?v=Z8BL8mdzWHI): A great tutorial on how to use Nix on MacOS.
- [NixOS: Everything Everywhere All At Once](https://www.youtube.com/watch?v=CwfKlX3rA6E): In case you want someone to convince you to try NixOS :3.
