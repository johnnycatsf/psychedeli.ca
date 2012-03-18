# Deploy tasks are most frequently system on the production server. They are
# wrappers around existing functionality except tailor-made for Capistrano.

namespace :deploy do
  desc "Restart the server and recompile the app"
  task :to_production do
    system "cd #{deploy_to}/current"
    Rake::Task['compile'].invoke
    Rake::Task['restart'].invoke
  end

  desc "Push to Heroku and recompile the app remotely"
  task :to_staging do
    system 'git push heroku master'
    system 'heroku rake:compile'
  end
end
