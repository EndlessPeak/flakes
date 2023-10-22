{ config, lib, pkgs, ... }:

{
  # Enable Nvidia GPU on NixOS
  # Tell Xorg to use the nvidia driver
  services = {
    # tlp.enable = true;
    auto-cpufreq.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    # It will install nvidia-vaapi-driver by default
  };
  # Make Sure openGL is enabled
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        #intel-media-driver
        #vaapiIntel
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    # Hardware Settings
    nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
      powerManagement = {
	enable = false;
	finegrained = false;
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      libva
      libva-utils
      glxinfo
    ];
  };

}
