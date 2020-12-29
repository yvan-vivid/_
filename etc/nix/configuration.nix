# Yvan Vivid - 'burning-pope' NixOS config

{ config, pkgs, ... }: let
  name = import ./name.nix;
  machines = {
    "burning-pope" = ./machines/burning-pope.nix;
    "wittie-box" = ./machines/wittie-box.nix;
  };
  machine = machines.${name};
in {
  imports = [
    ./hardware-configuration.nix
    machine
  ];
}
