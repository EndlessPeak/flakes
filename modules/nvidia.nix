{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # Enable Nvidia GPU on NixOS
  # Tell Xorg to use the nvidia driver
  services = {
    tlp.enable = true;
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
        intel-media-driver
        vaapiIntel
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
      powerManagement.enable = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      nvidia-offload
      libva
      libva-utils
      glxinfo
    ];
  };

}
