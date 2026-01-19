# Config Flakes

## Clean Install

```nix
# /etc/nixos/configuration.nix
nix.settings.trusted-users = ["lumi"];
nix.settings.experimental-features = ["nix-commands" "flakes"] # or something
```

```sh
nix-shell -p git
nix flake update
nix-prefetch-url --name displaylink-620.zip https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip
sudo nixos-rebuild switch --flake .#wumi
```
