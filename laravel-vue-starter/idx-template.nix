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
      wget https://github.com/laravel/vue-starter-kit/archive/refs/heads/main.zip
      unzip vue-starter-kit.zip
      mv vue-starter-kit/* "$out"/
      rm -rf vue-starter-kit
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}