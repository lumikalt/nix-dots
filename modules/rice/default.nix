{ ... }: {
  # Stylix is a sys module so it's not loaded here.
  imports = [
    ./env.nix
    ./hyprland.nix
    ./sway.nix
    ./waybar.nix
  ];
}
