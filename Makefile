# submodule only needed for generating lock
groovy-ls-lock:
	cd submodules/groovy-language-server && gradle2nix -o ./../../gradle2nix/ -l groovy-ls.gradle.lock

gll: groovy-ls-lock
