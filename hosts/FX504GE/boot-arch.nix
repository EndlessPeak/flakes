{ config, ... } @ args:

{
  boot.loader.grub.extraEntries = ''
    menuentry 'Arch Linux' {
      load_video
      set gfxpayload=keep
      insmod gzio
      insmod part_gpt
      insmod fat
      set root='hd0,gpt1'
      if [ x$feature_platform_search_hint = xy ]; then
          search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  181B-0DC0
      else
          search --no-floppy --fs-uuid --set=root 181B-0DC0
      fi
      echo	'Loading Linux linux ...'
      linux	/vmlinuz-linux root=UUID=a4b4fcff-5aa8-4191-b0fd-633be1beca83 rw  loglevel=3 quiet
      echo	'Loading initial ramdisk ...'
      initrd	 /intel-ucode.img /initramfs-linux.img
    }
  '';

}
