{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, nvf, ...}: {
    packages."x86_64-linux".default = (
    nvf.lib.neovimConfiguration{
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [./nvf.nix];
    }).neovim;
  };
}
