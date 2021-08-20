# Yvan Vivid - EFI boot setup

{ ... }: {
  boot.loader = {
    systemd-boot = { enable = true; editor = false; };
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };

    # might change later - no rush
    timeout = 20;
  };
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot.initrd.kernelModules = [ "i915" ];

  boot.kernelModules = [ "tun" ];
}
