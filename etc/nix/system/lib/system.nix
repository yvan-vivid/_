# Yvan Vivid - General System

{ pkgs, ... }: {
  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsaUtils
    python3

    # just for utilities
    pulseaudio
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Power / thermal
  services = {
    thermald.enable = true;
    upower.enable = true;
  };

  # Other services
  services = {
    openssh.enable = true;
    printing.enable = true;
    irqbalance.enable = true;
  };

  # udev rule additions
  services.udev.extraRules = ''
    ### ATmega32U4
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", TAG+="uaccess"
  '';

  # Security
  security = {
    sudo.enable = true;
    polkit.enable = true;
  };

  # Console setup
  console = {
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    iproute2.enable = true;
    useDHCP = false;
    hosts = {
      "127.0.0.1"     = [ "localhost.localdomain" "localhost" ];
      "192.168.68.88" = [ "burning-pope.localdomain" "burning-pope" ];
      "192.168.68.77" = [ "pinky.localdomain" "pinky" ];
      "192.168.68.78" = [ "wittie-box.localdomain" "wittie-box" ];
      "192.168.69.88" = [ "yvone.localdomain" "yvone" ];
    };
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig.enable = true;
  };
}
