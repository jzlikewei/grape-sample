# set path to app that will be used to configure unicorn
# note the trailing slash in this example
@dir = File.absolute_path(Dir.getwd)

@tmp = File.join(@dir, 'tmp')
Dir.mkdir(@tmp) unless File.exist?(@tmp)

sockets_path = File.join(@tmp, 'sockets')
Dir.mkdir(sockets_path) unless File.exist?(sockets_path)

pids_path = File.join(@tmp, 'pids')
Dir.mkdir(pids_path) unless File.exist?(pids_path)

worker_processes 2
working_directory @dir
timeout 30
# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen File.join(sockets_path, 'unicorn.sock'), backlog: 64
# Set process id path
puts File.join(pids_path, 'unicorn.pid')
pid File.join(pids_path, 'unicorn.pid')

# Set log file paths
log_path = File.join(@dir, 'log')
Dir.mkdir(log_path) unless File.exist?(log_path)

stderr_path File.join(log_path, 'unicorn.stderr.log')
stdout_path File.join(log_path, 'unicorn.stdout.log')
