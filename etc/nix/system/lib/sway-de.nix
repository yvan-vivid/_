# Yvan Vivid - Sway Desktop Environment

{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  
  hardware.brillo.enable = true;

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      # Sway extras
      swaybg swaylock swayidle xwayland
      i3status-rust

      # Launch/Notification
      mako wofi

      # A/V Settings
      pavucontrol kanshi redshift qjackctl cadence
      pamixer

      # Utilities
      slurp grim wl-clipboard
      wev wob 
      
      # DE Apps
      alacritty gparted mpv imv zathura foot

      # Other
      xdg-utils
    ];
  };
}
