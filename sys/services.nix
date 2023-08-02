{ config, pkgs, lib, ... }: {
  systemd.services = {
    # For wayland
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
    
    systemd-journal-flush.enable = false;
  };

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf udisks2 gcr ];
      implementation = "broker";
    };

    udisks2.enable = true;

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    # Extra power services in `power.nix`

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    atd.enable = true;
    fstrim.enable = true;

    # Bluetooth
    blueman.enable = true;

    gnome.gnome-keyring.enable = true;

    # Monitor Hotswap
    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };
  };
}
