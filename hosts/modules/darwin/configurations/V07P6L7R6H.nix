{...}: let
  username = "inf10906";
  hostname = "V07P6L7R6H";
in {
  homebrew.casks = [
    "Rectangle"
    "alt-tab"
    "firefox"
    "flameshot"
    "google-chrome"
    "google-drive"
    "hammerspoon"
    "maccy"
    "middleclick"
    "stats"
  ];

  networking.hostName = hostname;

  imports = [
    ../shared
    (../users + "/${username}.nix")
  ];

  users.knownUsers = [username];
}
