{ pkgs, version ? "latest", ... }: {
	
    packages = [
      pkgs.php83
      pkgs.php83Packages.composer
      pkgs.php83Extensions.redis
      pkgs.nodejs_20
      pkgs.yarn
    ];

    bootstrap = ''
			mkdir "$out"
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}