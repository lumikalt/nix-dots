{ pkgs, lib, inputs, ... }: let
  plugged = pkgs.writeShellScript "plugged" ''
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)

    # systemctl --user --machine=1000@ start syncthing
    hyprctl --batch 'keyword decoration:drop_shadow 1 ; keyword animations:enabled 1'
  '';

  unplugged = pkgs.writeShellScript "unplugged" ''
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)

    # systemctl --user --machine=1000@ stop syncthing
    hyprctl --batch 'keyword decoration:drop_shadow 0 ; keyword animations:enabled 0'
  '';
in {
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${plugged}"      
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${unplugged}"      
  '';

  services = {
    auto-cpufreq.enable = true;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        #START_CHARGE_THRESH_BAT0=75;
        #STOP_CHARGE_THRESH_BAT0=90;
        SOUND_POWER_SAVE_ON_AC=0;
        SOUND_POWER_SAVE_ON_BAT=1;
        RUNTIME_PM_ON_AC="on";
        RUNTIME_PM_ON_BAT="auto";
        NATACPI_ENABLE=1;
        TPACPI_ENABLE=1;
        TPSMAPI_ENABLE=1;
        CPU_SCALING_GOVERNER_ON_AC="none";
        CPU_SCALING_GOVERNER_ON_BAT="none";
      };
    };
  };
}
