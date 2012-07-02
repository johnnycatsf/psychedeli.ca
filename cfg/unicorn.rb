## Unicorn configuration

# Store the PID in the Capistrano app dir
pid "/home/necromancer/src/blog/shared/pids/unicorn.pid"

# What ports/sockets to listen on, and what options for them.
listen 7000, backlog: 64

working_directory "/home/necromancer/src/blog/current"

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
stderr_path "/home/necromancer/src/blog/shared/log/error.log"

# Where stdout gets logged
stdout_path "/home/necromancer/src/blog/shared/log/access.log"
