Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each do |f|
  require f
end

if ARGV[1]
  source = File.open(ARGV[1])
else
  source = ARGF
end

instructor = Assembly.assemble(STDOUT)

begin
  instructor.issue_commands_from(source)
rescue => e
  STDERR.puts("ERROR: #{e.message}")
end

