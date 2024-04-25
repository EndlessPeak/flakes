{ config, pkgs, lib, ... }:
{
  # Correctly detect microphone plugged in a 4-pin 3.5mm (TRRS) jack
  # https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture
  boot.extraModprobeConfig = ''
    options snd_hda_intel index=0 model=dell-headset-multi
  '';
}
  