{ pkgs ? import <nixpkgs> {} }:
with pkgs; let
  py-pkgs = pp: with pp; [
    mypy
    neovim
    pytest
    pylint
    ipython
  ];
  python-with-packages = python39.withPackages py-pkgs;
in pkgs.mkShell {
  buildInputs = [
    python-with-packages 
  ]; 
}
