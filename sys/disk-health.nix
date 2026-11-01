{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nvme-cli
    smartmontools
  ];

  # The NVMe drive has reported unrecovered read errors and failed an extended
  # self-test (Oct 2026). Re-run it periodically to see whether it is getting
  # worse. Check the result with: pkexec nvme self-test-log /dev/nvme0n1
  systemd.services.nvme-self-test = {
    description = "Start an extended NVMe self-test";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nvme-cli}/bin/nvme device-self-test /dev/nvme0n1 -s 2";
    };
  };

  systemd.timers.nvme-self-test = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-15 03:00";
      # Run at next boot if the laptop was off.
      Persistent = true;
    };
  };
}
