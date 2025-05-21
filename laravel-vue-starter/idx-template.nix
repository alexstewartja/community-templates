{ pkgs, version ? "latest", ... }: {
	
    packages = [
      pkgs.php84
      pkgs.php84Packages.composer
      pkgs.php84Extensions.redis
      pkgs.nodejs_20
      pkgs.yarn
    ];

    bootstrap = ''
      mkdir composer-home
      export COMPOSER_HOME=./composer-home
			mkdir "$out"
      composer self-update
      composer global require laravel/installer
      laravel new "$out" --vue --pest
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}