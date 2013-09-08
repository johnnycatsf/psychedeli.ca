namespace :deploy do
  task :heroku_toolbelt do
    sh 'gem install heroku'
  end


  task :ssh_configuration do
    ssh_config = %(
    Host heroku.com
      StrictHostKeyChecking no
      CheckHostIP no
      UserKnownHostsFile=/dev/null
    )
    File.write(File.expand_path("~/.ssh.config"), 'rw+') do |f|
      f.puts ssh_config
    end
  end

  task :add_keys_to_heroku do
    sh 'heroku keys:clear'
    sh 'heroku keys:add'
  end

  task :push_to_heroku do
    sh 'git remote add heroku git@heroku.com:psychedelica.git'
    sh 'git push heroku master'
  end
end

desc "Deploy to Heroku from Travis-CI"
task :deploy => %w(
  deploy:heroku_toolbelt
  deploy:ssh_configuration
  deploy:heroku_keys
  deploy:application_to_heroku
  airbrake:deploy
)
