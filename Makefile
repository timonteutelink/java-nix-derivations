# submodules only needed for generating lock
groovy-ls-lock:
	cd submodules/groovy-language-server && gradle2nix -o ./../../gradle2nix/ -l groovy-ls.gradle.lock

groll: groovy-ls-lock

gradle-ls-lock:
	cd submodules/vscode-gradle && gradle2nix -o ./../../gradle2nix/ -l gradle-ls.gradle.lock

grall: gradle-ls-lock
