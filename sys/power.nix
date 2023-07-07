{ config, pkgs, lib, ... }: {
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
