{ pkgs, version ? "latest", importAlias ? "@/*",  language ? "ts", packageManager ? "npm", srcDir ? false, eslint ? false, app ? false, tailwind ? false, ... }: {
    packages = [
      pkgs.nodejs
      pkgs.yarn
      pkgs.nodePackages.pnpm
      pkgs.bun
    ];
    bootstrap = ''
      mkdir "$out"
      npx --yes create-next-app@${version} "$out" \
        --import-alias=${importAlias} \
        --${language} \
        --use-${packageManager} \
        ${if eslint then "--eslint" else "--no-eslint" } \
        ${if srcDir then "--src-dir" else "--no-src-dir" } \
        ${if app then "--app" else "--no-app" } \
        ${if tailwind then "--tailwind" else "--no-tailwind" }
      mkdir -p "$out"/.idx
      cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
