require "socket"

port = 3000
server = TCPServer.new(port) # [TCPServer]

# Wait for connection
socket = server.accept # [TCPSocket]
puts "Got a connection!"

# 1st step
loop do
  line = socket.readline.chomp
  puts "Read: #{line}"
  break if line.bytesize == 0
end