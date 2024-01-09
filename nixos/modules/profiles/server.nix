{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/headless.nix")
    (modulesPath + "/profiles/minimal.nix")
  ];
}
