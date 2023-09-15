{pkgs, ...}: {
  imports = [
    ../../programs/neovim
    ../../programs/bash
    ../../programs/zsh
    ../../programs/starship
    ../../programs/git
    ../../programs/sapling
    ../../programs/tmux
    ../../programs/zellij
    ../../programs/gh
    ../../programs/zoxide
    ../../programs/fzf
    ../../programs/just
    ../../programs/openssl
    ../../programs/bat
    ../../programs/lsd
    ../../programs/broot
    ../../programs/direnv
    ../../programs/any-nix-shell
    ../../programs/ls
  ];

  home.packages = with pkgs;
    [
      unstable.fq # jq for binary formats
      act # github actions testing
      bandwhich # network utilization by process
      bottom # top with graphs
      browsh # terminal browser
      cachix
      cloc # source code line counter
      cmake
      coreutils
      ctags
      curl
      dasel
      du-dust # fancy du
      duf # df alternative
      fd # fast file search
      file
      findutils
      glances # glances an eye on your system
      glow # renders markdown on command line
      gnumake
      gnused
      # graphviz
      grpcurl
      hexyl
      htmlq # Like jq, but for HTML
      htop # fancy top
      httpie
      hyperfine
      jp # jmespath
      jq
      jrnl
      lazygit
      lsof
      neofetch
      oha # HTTP load generator inspired by rakyll/hey with tui animation
      openssh
      perlPackages.vidir # edit files in EDITOR
      ps
      ripgrep
      rsync
      spotify-tui
      tealdeer # faster tldr
      tokei # displays code statistics
      tree
      ultralist
      unstable.procs # replacement for ps
      yq
      yubikey-manager
    ]
    ++ lib.optionals stdenv.isLinux [
      unstable.btop # monitor resources
      iotop
      lshw # list hardware
      pueue # task management tool
      psmisc
      screenfetch # fetch system/theme information
      sysstat
      thefuck # fix commands
      wget
    ]
    ++ lib.optionals stdenv.isDarwin [
      m-cli # controls apps from command line
    ];
}
