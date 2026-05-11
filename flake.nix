{
  description = "Duncha's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... } @ inputs:
  let
    system = "x86_64-linux";
    user = "duncha";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs system user; };
	
	modules = [
	  ./hosts/desktop/hardware-configuration.nix
	  ./hosts/desktop/configuration.nix
	  catppuccin.nixosModules.catppuccin # Catppuccin theme

	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs user; };

	    home-manager.users.${user} = {
	      imports = [
	        ./home/default.nix
		catppuccin.homeModules.catppuccin
	      ];
	    };
	  }
	];
      };
    };
  };
}
