{ pkgs, ... }:

{
  users.groups = {
    leesin = { };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leesin = {
    name = "leesin";
    home = "/home/leesin";
    isNormalUser = true;
    description = "Lee Sin";
    shell = pkgs.zsh;
    # the hashed password with salt is generated by run `mkpasswd`.
    hashedPassword = "$y$j9T$k2Uh2iPXvyHB6f4aS0w3O1$T8iSQL2RFO0gEYi8Sx0R1teqTeGA3oFeoYoJ0dfZHT1";
    extraGroups = [ 
      "leesin" 
      "users"
      "networkmanager" 
      "wheel"
      "docker"
      "dialout"
    ];
  };
}
