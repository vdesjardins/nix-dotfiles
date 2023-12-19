{pkgs, ...}: {
  wayland.windowManager.sway.swaynag = {
    settings = {
      custom = {
        dismiss-button = "Dismiss";
        background = "24283B";
        border = "414868";
        border-bottom = "414868";
        button-background = "414868";
        text = "c0caf5";
        border-bottom-size = "2";
        message-padding = "5";
        details-border-size = "2";
        button-border-size = "0";
        button-gap = "5";
        button-dismiss-gap = "5";
        button-margin-right = "5";
        button-padding = "5";
      };
    };
  };
}
