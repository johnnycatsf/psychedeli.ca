# Deploy tasks are most frequently system on the production server. They are
# wrappers around existing functionality except tailor-made for Capistrano.

namespace :deploy do
  desc "Restart the server and recompile the app"
  task :update_content do
    system "cd #{deploy_to}/current"
    Rake::Task['compile'].invoke
    Rake::Task['restart'].invoke
  end
end
