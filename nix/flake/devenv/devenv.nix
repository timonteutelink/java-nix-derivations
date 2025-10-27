localFlake:
{ lib, config, self, inputs, ... }: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = { pkgs, system, ... }: {
    devenv.shells.default =
      {
        name = "";

        env = { };

        packages = with pkgs; [
          inputs.gradle2nix.packages.${system}.default
        ];

        languages = {
          java = {
            enable = true;
            gradle.enable = true;
            jdk.package = pkgs.jdk21_headless;
          };
        };

        git-hooks = {
          settings = { };
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };

        enterShell = ''
          echo 'Biep Boop'
        '';

        scripts =
          { };
      };
  };
}
