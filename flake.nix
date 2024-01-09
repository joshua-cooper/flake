{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs:
    let
      inherit (inputs.nixpkgs) lib;

      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];

      pkgsFor = system: import inputs.nixpkgs {
        inherit system;
      };

      eachPkgs = f: lib.genAttrs systems (s: f (pkgsFor s));

      mkNixosSystem = configuration: lib.nixosSystem {
        inherit (configuration) modules;
        specialArgs = { inherit inputs; };
      };
    in
    {
      formatter = eachPkgs (pkgs: pkgs.nixpkgs-fmt);
      nixosConfigurations = lib.mapAttrs (_: mkNixosSystem) (import ./nixos/configurations);
    };
}
