localFlake:
{ ... }: {
  perSystem = { system, ... }: {
    formatter =
      localFlake.withSystem system ({ pkgs, ... }: pkgs.nixfmt-classic);
  };
}

