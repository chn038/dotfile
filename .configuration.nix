# anj in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/cachix.nix
    ];

  fonts.packages = with pkgs; [
   noto-fonts
   noto-fonts-cjk-sans
   noto-fonts-color-emoji
   nerd-fonts.terminess-ttf
   ttf-tw-moe
   corefonts
   vista-fonts
   vista-fonts-cht
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest zen kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_TW.UTF-8";
    LC_IDENTIFICATION = "zh_TW.UTF-8";
    LC_MEASUREMENT = "zh_TW.UTF-8";
    LC_MONETARY = "zh_TW.UTF-8";
    LC_NAME = "zh_TW.UTF-8";
    LC_NUMERIC = "zh_TW.UTF-8";
    LC_PAPER = "zh_TW.UTF-8";
    LC_TELEPHONE = "zh_TW.UTF-8";
    LC_TIME = "zh_TW.UTF-8";
  };
  i18n.inputMethod = {
    enable = true;
    enableGtk2 = true;
    enableGtk3 = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-moegirl
      kdePackages.fcitx5-chinese-addons
      kdePackages.fcitx5-configtool
      (catppuccin-fcitx5.override {
          withRoundedCorners = true;
      })
      ];
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.herochen = {
    isNormalUser = true;
    description = "HeroChen";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # kdePackages.kate
      thunderbird
      libreoffice-qt-fresh
    ];
  };

  # Install firefox.
  programs.firefox = {
      enable = true;
      package = pkgs.firefox-esr;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    neovim
    vesktop
    librewolf-bin
    gcc glibc_multi glib glibtool
    tree-sitter
    fd ripgrep bat
    uv
    cachix direnv
    btop-cuda
    lazygit ansible
    stow
    python3
    unzip
    cargo
    zsh starship
    zellij
    clang clang-tools luajitPackages.lua-lsp
    # python lsp
    python3Packages.python-lsp-server black
    # nix lsp
    nixd
    steam-run
    wl-clipboard
    nodejs

    lm_sensors liquidctl
    (catppuccin.override {
        accent = "mauve";
    })
    (catppuccin-kde.override {
        flavour = ["macchiato"];
        accents = [ "mauve" ];
    })
    (catppuccin-gtk.override {
        variant = "macchiato";
        accents = [ "mauve" ];
    })
    (catppuccin-sddm.override {
        flavor = "macchiato";
    })
    catppuccin-cursors.macchiatoMauve
    (catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "mauve";
    })

    p7zip
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    lutris
  ];

  environment.variables = {
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  services.ollama = {
    enable = true;
    openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "avit";
    };
  };

  programs.nix-ld.enable = true;

  programs.coolercontrol.enable = true;

  programs.kdeconnect.enable = true;

  services.envfs.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  hardware.bluetooth = {
      enable = true;
      settings = {
          General = {
              MultiProfile = "multiple";
              FastConnectable = "true";
              JustWorksRepairing = "confirm";
          };
      };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
