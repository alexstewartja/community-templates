{ pkgs, version ? "latest", ... }: {
	
    packages = [
      pkgs.php83
      pkgs.php83Packages.composer
      pkgs.php83Extensions.redis
      pkgs.nodejs_20
      pkgs.yarn
    ];

    bootstrap = ''
      composer global require laravel/installer
      export PATH="$PATH:$HOME/.config/composer/vendor/bin"
			mkdir "$out"
      laravel new "$out" --vue --pest
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}