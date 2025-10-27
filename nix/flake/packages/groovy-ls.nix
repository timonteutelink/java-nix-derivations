localFlake:
{ inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    packages.groovy-ls =
      let
        src = pkgs.fetchFromGitHub {
          owner = "GroovyLanguageServer";
          repo = "groovy-language-server";
          rev = "0466842f2b9e7d2c4620e81e3acf85e56c71097f";
          hash = "sha256-2KRMrJGcx52uBQGyZ8cRW5y9ZUwxMoe1eF90oN3Yppw=";
        };
        jdk = pkgs.jdk21_headless;
      in
      inputs.gradle2nix.builders.${system}.buildGradlePackage {
        pname = "groovy-language-server";
        version = "git-${builtins.substring 0 7 (src.rev or "unknown")}";

        inherit src;

        lockFile = ./../../../gradle2nix/groovy-ls.gradle.lock;

        java = jdk;

        gradleBuildTask = "build";
        gradleBuildFlags = [ "build" ];
        gradleFlags = [ "--no-daemon" "--stacktrace" ];

        installPhase = ''
          install -Dm644 build/libs/source.jar \
            $out/share/java/groovy-language-server/groovy-language-server.jar

          install -Dm644 build/libs/source-all.jar \
            $out/share/java/groovy-language-server/groovy-language-server-all.jar

          makeWrapper ${pkgs.jre_headless}/bin/java $out/bin/groovy-language-server \
            --add-flags "-jar $out/share/java/groovy-language-server/groovy-language-server-all.jar"
        '';

        nativeBuildInputs = [ pkgs.makeWrapper ];
      };
  };
}

