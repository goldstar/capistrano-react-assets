namespace :react_assets do

  # this is what compiles and packages the assets locally. It compiles the
  # javascripts and tars up the generated files.
  task :package_and_upload do
    run_locally do
      execute "rm -f #{fetch(:assets_tar)}"
      execute "npm install --production ."
      execute "rm -rf #{fetch(:assets_package_path)}"
      execute "NODE_ENV=production npm run-script build"
      execute "tar cjf #{fetch(:assets_tar)} #{fetch(:assets_package_path)}"
    end

    # this will create the public/javascripts directory if it needs to and
    # will then upload the assets.tar.bz2 file there. after that it will
    # unpack the tar.
    on roles(:app) do
      execute "if [[ ! -d #{fetch(:remote_assets_path)} ]]; then mkdir -p #{fetch(:remote_assets_path)}; fi"
      upload! fetch(:assets_tar), File.join(fetch(:deploy_to), "current")
      execute "tar xjf #{fetch(:remote_assets_tar)} -C #{File.join(fetch(:deploy_to), "current")}"
    end

  end

  # clean up the remote assets tar
  task :cleanup do
    on roles(:app) do
      execute "rm -f #{fetch(:remote_assets_tar)}"
    end
  end

  task :prepare_environment do
    run_locally do
      execute "npm cache clean"
      execute "npm config set registry https://registry.npmjs.org/"
      execute "npm config set proxy 'http://proxy:3128'"
      execute "npm config set http-proxy 'http://proxy:3128'"
      execute "npm config set https-proxy 'http://proxy:3128'"
    end
  end

end

