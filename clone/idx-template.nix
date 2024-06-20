{pkgs, repo, ...}: 
let 
  devNix = pkgs.writeText "dev.nix" ''
    {pkgs, ...}: {
        packages = [
            pkgs.python3
        ];

        idx.workspace.onCreate = {
            init = '''
              highlight='\033[1;32m'
              hyperlink='\033[4;34m'
              nc='\033[0m'

              host="$(echo ${repo} | awk -F[/:] '{print $4}')"

              echo -e "Please navigate to '''''${hyperlink}https://$host/new-password'''''${nc} and paste the output script into this terminal..."
              echo -e "'''''${highlight}Paste and press '''''${nc}'''''${hyperlink}Ctrl+D'''''${nc}'''''${highlight} when done...'''''${nc}"

              bash -c "$(cat)"
              echo -e "'''''${highlight}Success, proceeding with clone...'''''${nc}..."

              git clone ${repo} /home/user/repo
              code -r /home/user/repo
            ''';
        };
    }
  '';
in {
    packages = [
        pkgs.coreutils
        pkgs.curl
        pkgs.gzip
        pkgs.gnutar
    ];

    bootstrap = ''
      mkdir -p "$out/.idx"
      install --mode u+rw ${devNix} "$out"/.idx/dev.nix
    '';
}
