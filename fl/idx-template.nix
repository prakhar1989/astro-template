{ pkgs, ... }: {
  packages = [ pkgs.flutter ];

  bootstrap = ''
    flutter create "$WS_NAME"
    mkdir -p "$WS_NAME"/.idx
    cp ${./dev.nix} app/.idx/dev.nix
    chmod +w app/.idx/dev.nix
    mv "$WS_NAME" "$out"
  '';
}
