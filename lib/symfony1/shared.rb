namespace :shared do
  namespace :databases do
    desc "Download database config file from remote server"
    task :to_local do
      download("#{shared_path}/#{databases_config_path}", databases_config_path, :via => :scp)
    end

    desc "Upload database config to remote server"
    task :to_remote do
      upload(databases_config_path, "#{shared_path}/#{databases_config_path}", :via => :scp)
    end
  end

  namespace :log do
    desc "Download all logs from remote folder to local one"
    task :to_local do
      download("#{shared_path}/log", "./", :via => :scp, :recursive => true)
    end

    desc "Upload all logs from local folder to remote one"
    task :to_remote do
      upload("log", "#{shared_path}/", :via => :scp, :recursive => true)
    end
  end

  namespace :uploads do
    desc "Download all files from remote web/uploads folder to local one"
    task :to_local do
      download("#{shared_path}/#{web_path}/uploads", "#{web_path}", :via => :scp, :recursive => true)
    end

    desc "Upload all files from local web/uploads folder to remote one"
    task :to_remote do
      upload("#{web_path}/uploads", "#{shared_path}/#{web_path}", :via => :scp, :recursive => true)
    end
  end

  namespace :symfony do
    desc "Downloads symfony framework to shared directory"
    task :download do
      prompt_with_default(:version, symfony_version)

      try_sudo <<-CMD
        if [ ! -d #{shared_path}/symfony-#{version} ]; then
          wget -q http://www.symfony-project.org/get/symfony-#{version}.tgz -O- | tar -zxf - -C #{shared_path};
        fi
      CMD
    end
  end
end
