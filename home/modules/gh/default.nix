{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  config = mkIf config.programs.gh.enable {
    home.packages = with pkgs.gitAndTools; [
      gh
    ];

    # TODO: a ~/.config/gh/hosts.yml file need to be created with credentials
    # ex.:
    # github.com:
    #   user: vdesjardins
    #   oauth_token: <REDACTED>
    programs.gh = {
      settings = {
        git_protocol = "ssh";

        aliases = {
          co = "pr checkout";
          c = "pr create";
          cf = "pr create -f";
          m = "pr merge -r -d";
          s = "pr status";
          ch = "pr checks -i 2 --watch";
          pw = "pr view --web";
          pv = "pr view -c";
          pu = "pr view --json url";
          pd = "pr diff";
          rv = "repo view --web";
          ru = "gh repo view --json url -q .url";
        };
      };

      extensions = with pkgs.unstable; [
        gh-dash
        gh-eco
        gh-markdown-preview
        # gh-f
        # gh-get-asset
        # gh-look
        # gh-ls
        # gh-notify
        # gh-profile
        # gh-pulls
        # gh-s
        # gh-sql
      ];
    };

    # TODO: support linux
    programs.zsh.shellAliases = {
      ghpc = "gh pu | jq '.url' -Mr | pbcopy";
      ghrc = "gh ru | pbcopy";
    };
  };
}
