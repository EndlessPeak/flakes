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
  services = {
    tlp.enable = true;
    auto-cpufreq.enable = true;
  };

  hardware = {
    opengl = {
      # Other config options inherit from default.nix
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