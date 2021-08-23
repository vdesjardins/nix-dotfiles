{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      pandoc # convert markup files
      wkhtmltopdf # convert html to pdf
    ];
}
