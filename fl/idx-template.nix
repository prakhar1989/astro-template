{ pkgs, ... }: {
  packages = [ pkgs.nodejs_20 pkgs.bubblewrap ];
  bootstrap = ''
    npm config ls
    date
    bwrap --unshare-net --bind / / --dev /dev npx --offline --loglevel verbose -y @angular/cli new --skip-git --defaults --skip-install --directory "$WS_NAME" "$WS_NAME"
    date
    mkdir "$WS_NAME"/.idx
    cp ${./dev.nix} "$WS_NAME"/.idx/dev.nix && chmod +w "$WS_NAME"/.idx/dev.nix
    mv "$WS_NAME" "$out"
  '';
}
