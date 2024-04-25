{ config, lib, pkgs, ... }:

# let
#   vscodeWithExtension = pkgs.vscode-with-extensions.override {
#     # Add extensions
#     vscodeExtensions = with pkgs.vscode-extensions; [
#       ms-python.python
#       ms-vscode.cpptools
#       ms-vscode.cmake-tools
#       ms-toolsai.jupyter
#       catppuccin.catppuccin-vsc
#       llvm-vs-code-extensions.vscode-clangd
#     ];
# #     ++ with pkgs-unstable.vscode-extensions;[
# #       ms-vscode.cpptools-extension-pack
# #     ];
#   };
# in
{
  environment.systemPackages = with pkgs;[
    # vscode-fhs
    vscode
  ];
}