localFlake:
{ inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    packages.gradle-ls =
      let
        src = pkgs.fetchFromGitHub {
          owner = "microsoft";
          repo = "vscode-gradle";
          rev = "280ce07480530c12b47402ff3b31802a985b2065";
          hash = "sha256-aKNJ9C6TiQhEGDj1BuLoDSBDoyyywXG4Giq5Re0QS9A=";
        };
        jdk = pkgs.jdk21_headless;
      in
      inputs.gradle2nix.builders.${system}.buildGradlePackage {
        pname = "gradle-language-server";
        version = "git-${builtins.substring 0 7 (src.rev or "unknown")}";

        inherit src;

        lockFile = ./../../../gradle2nix/gradle-ls.gradle.lock;

        java = jdk;

        gradleBuildTask = "installDist";
        gradleBuildFlags = [ "installDist" ];
        gradleFlags = [ "--no-daemon" "--stacktrace" ];

        installPhase = ''
          echo "Problem tries to fetch some eclipse stuff during build. Need to disable this or prefetch it."
          exit 1
        '';

        nativeBuildInputs = [ pkgs.makeWrapper ];
      };
  };
}


