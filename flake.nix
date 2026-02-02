{
  description = "Andrewix - Dendritic Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree = {
      url = "github:vic/import-tree";
    };

    flake-aspects = {
      url = "github:vic/flake-aspects";
    };

    # nvf = {
    #   url = "github:NotAShelf/nvf";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    serena = {
      url = "github:oraios/serena";
    };

    aic8800 = {
      url = "github:kurumeii/aic8800-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./modules/flake/hosts.nix
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import inputs.rust-overlay) ];
          };
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [ pkgs.nodejs ];
          };
        };
    };
}
