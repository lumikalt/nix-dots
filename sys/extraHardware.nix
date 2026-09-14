{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
    enable32Bit = true;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
  };

  # AMD/Xilinx Vivado cable drivers (Digilent Basys3 USB-JTAG, Xilinx
  # FTDI-based cables, Xilinx Platform Cable USB). /etc/udev/rules.d is
  # read-only on NixOS, so these must be declared here rather than dropped
  # in by Vivado's own install_drivers script. Source: <Vivado install>/
  # 2026.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/
  services.udev.extraRules = ''
    # 52-xilinx-digilent-usb.rules
    ATTRS{idVendor}=="1443", MODE:="666"
    ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{manufacturer}=="Digilent", MODE:="666"

    # 52-xilinx-ftdi-usb.rules
    ATTRS{idVendor}=="0403", ATTRS{bInterfaceNumber}=="00",\
    PROGRAM="/bin/sh -c '\
        echo -n $id:1.0 > /sys/bus/usb/drivers/ftdi_sio/unbind;\
        echo -n $id:1.1 > /sys/bus/usb/drivers/ftdi_sio/unbind\
    '"
    ACTION=="add", ATTRS{idVendor}=="0403", MODE:="666"

    # 52-xilinx-pcusb.rules
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0008", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0007", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0009", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000d", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="000f", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0013", MODE="666"
    ATTR{idVendor}=="03fd", ATTR{idProduct}=="0015", MODE="666"
  '';
}
