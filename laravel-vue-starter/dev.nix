# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{pkgs}: {
  # Which nixpkgs channel to use.
  channel = "stable-24.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.php83
    pkgs.php83Packages.composer
    pkgs.php83Extensions.redis
    pkgs.nodejs_20
    pkgs.yarn
  ];
  # Sets environment variables in the workspace
  env = {};
  services.mysql = {
    enable = true;
    package = pkgs.mariadb_114;
  };
  services.redis = {
    enable = true;
    port = 6379;
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "laravel.vscode-laravel"
      "onecentlin.laravel5-snippets"
      "onecentlin.laravel-blade"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        composer-install = "composer install";
        generate-app-key = "php artisan key:generate --ansi";
        touch-sqlite = "[ ! -f database/database.sqlite ] && touch database/database.sqlite";
        create-db = "mariadb -u root -e \"create database laravel;\"";
        migrate = "php artisan migrate --graceful --ansi";
        yarn-install = "yarn install";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "README.md" "resources/views/app.blade.php" ".env" ];
      };
      onStart = {
        composer-install = "composer install";
        yarn-install = "yarn install";
        yarn-build-watch = "yarn run build --watch";
      };
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["php" "artisan" "serve" "--port" "$PORT" "--host" "0.0.0.0"];
          manager = "web";
        };
      };
    };
  };
}
