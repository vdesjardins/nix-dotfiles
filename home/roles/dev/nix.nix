{pkgs, ...}: {
  modules.desktop.editors.neovim.lang.nix = true;

  home.packages = with pkgs; [
    nixpkgs-fmt
    # nix-linter
    nix-bisect # bisect nix builds
    nix-init # generate nix packages
    nix-tree
    nix-prefetch
    nix-output-monitor
    nurl # generate nix fetcher calls
    nvd # package version diff tool
  ];
}
