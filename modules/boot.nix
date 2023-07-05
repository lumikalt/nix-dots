{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "module_blacklist=nouveau"
      "cgroup_no_v1=all"
      "systemd.unified_cgroup_hierarchy=yes"
      "console=tty1"
      "mitigations=off"
      "nowatchdog"
      "tsc=reliable"
      "b43.allhwsupport=1"
      "loglevel=3"
      "quiet"
    ];

    supportedFilesystems = ["btrfs" "ntfs" "ext4"];
  };

}
