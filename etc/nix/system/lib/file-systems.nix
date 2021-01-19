{ ... }: with (import ./mount-util.nix); {
  fileSystems = createFileSystems (loadMounts ../mounts.json);
}
