{pkgs, ...}: {
  services.window-manager.i3.enable = true;
  programs.rofi.enable = true;
  services.dunst.enable = true;
}
