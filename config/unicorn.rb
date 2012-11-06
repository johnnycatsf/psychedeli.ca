## Unicorn configuration

base_dir = "/home/necromancer/src/blog/shared"

# Store the PID in the Capistrano app dir
pid_file = "#{base_dir}/tmp/unicorn.pid"
pid pid_file

# What ports/sockets to listen on, and what options for them.
listen 2000, backlog: 64

working_directory base_dir.gsub('/shared', '/current')

# What the timeout for killing busy workers is, in seconds
timeout 60

# Whether the app should be pre-loaded
preload_app false

# How many worker processes
worker_processes 4

# What to do before we fork a worker
before_fork do |server, worker|
  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{pid_file}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

# Where stderr gets logged
stderr_path "#{base_dir}/log/error.log"

# Where stdout gets logged
stdout_path "#{base_dir}/log/access.log"
