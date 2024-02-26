{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.modules.desktop.tools.buku;
in {
  options.modules.desktop.tools.buku = {
    enable = mkEnableOption "buku";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [buku];

    programs.zsh.shellAliases = {
      b = "buku --suggest";
    };

    modules.desktop.browsers.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      {
        package = bukubrow;
        area = "navbar";
        nativeMessagingHost = pkgs.bukubrow;
      }
    ];

    xdg.dataFile.buku.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/data/buku/share";
  };
}
