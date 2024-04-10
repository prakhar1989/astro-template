{ pkgs, ... }: {
  channel = "stable-23.05"; # "stable-23.05" or "unstable"
  packages = [];
  idx.extensions = [];
  idx.previews = {
    enable = true;
    previews = [];
  };
}
