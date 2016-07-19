# Capistrano React Assets

Package react assets locally (once) and upload to each host. This saves you time since the npm modules are only installed (and compiled) once, and the assets are only packaged once. The assets are then compressed, shipped, and unpacked.

# Setup

Add the library to your `Gemfile`:

```
gem 'capistrano-react-assets'
```

Add the library to your `Capfile`:

```
require 'capistrano/react-assets'
```

Provide some setup and invoke the commands in your `config/deploy.rb` or `config/deploy/ENVIRONMENT.rb`:

```
set :assets_tar, "assets.tar.bz2"
set :assets_package_path, "public/webpack"
set :remote_assets_tar, File.join(fetch(:deploy_to), "current", fetch(:assets_tar))
set :remote_assets_path, File.join(fetch(:deploy_to), "current", fetch(:assets_package_path))

before "unicorn_restart", "react_assets:prepare_environment"
after "react_assets:prepare_environment", "react_assets:package_and_upload"
after "react_assets:package_and_upload", "react_assets:cleanup"
```

