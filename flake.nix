{
  description = "A template that shows all standard flake outputs";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      disko,
      nixpkgs,
      ...
    }@inputs: {
      nixosConfigurations.cheriu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          disko.nixosModules.disko
          ./disko-config.nix
        ];
      };

    };
}
