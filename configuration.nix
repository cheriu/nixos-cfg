{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 启用 Flakes 特性以及配套的船新 nix 命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # Flakes 通过 git 命令拉取其依赖项，所以必须先安装好 git
    git
    vim
    wget
  ];
  # 将默认编辑器设置为 vim
  environment.variables.EDITOR = "vim";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  
  users = {
    mutableUsers = false;

    # generate password hash by `mkpasswd -m sha-512 mySuperSecretPassword`
    users = {
      root.initialPassword = "123456";

      cheriu = {
        isNormalUser = true;
        home = "/home/cheriu";
        uid = 1000;
        initialPassword = "123456";
        description = "cheriu";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        packages = with pkgs; [
          firefox
        #  thunderbird
        ];

      };
    };
  };
}
