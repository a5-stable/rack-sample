require "socket"

port = 3000
server = TCPServer.new(port) # [TCPServer]

# Wait for connection
socket = server.accept # [TCPSocket]
puts "Got a connection!"

# 2nd step: with response
# curl localhost:3000/hello
#=> Hello World

loop do
  line = socket.readline.chomp # https://docs.ruby-lang.org/ja/latest/method/IO/i/readline.html
  puts "Read: #{line}"
  if line.bytesize == 0
    # Request / Response は ただの文字列
    socket.write "HTTP/1.1 200 OK\r\n" # https://docs.ruby-lang.org/ja/latest/method/IO/i/write.html
    socket.write "\r\n"
    socket.write "Hello World\r\n"
    socket.close
    break
  end
end