{ pkgs, ... }:
{
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
      wantedBy = [ "multi-user.target" ];
    };

    # systemd-journal-flush.enable = false;

    # Monitor Hotswap
    kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
      };
    };

    dlm.wantedBy = [ "milti-user.target" ];
  };

  xdg.portal = {
    enable = true;

    configPackages = [ pkgs.niri-unstable ];
    config.niri = {
      # This does not support extending existing configs, so we have to vendor the original config.
      # Keep in sync with https://github.com/niri-wm/niri/blob/main/resources/niri-portals.conf
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Access" = [ "gtk" ];
      "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      # CHANGES
      # use gtk file picker instead of nautilus (which is not installed)
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };

    extraPortals = with pkgs; [
      gnome-keyring
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [
        dconf
        udisks2
        gcr
      ];
      implementation = "broker";
    };

    xserver.videoDrivers = [
      "displaylink"
      "modesetting"
    ];

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

    gnome.gnome-keyring.enable = true;
  };
}
