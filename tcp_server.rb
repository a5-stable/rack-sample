require "socket"

port = 3000
server = TCPServer.new(port) # [TCPServer]

# Wait for connection
socket = server.accept # [TCPSocket]
puts "Got a connection!"

# # 1st step
# loop do
#   line = socket.readline.chomp
#   puts "Read: #{line}"
#   break if line.bytesize == 0
# end

# # 2nd step: with response
# # curl localhost:3000/hello
# #=> Hello World
# loop do
#   line = socket.readline.chomp # https://docs.ruby-lang.org/ja/latest/method/IO/i/readline.html
#   puts "Read: #{line}"
#   if line.bytesize == 0
#     # Request / Response は ただの文字列
#     socket.write "HTTP/1.1 200 OK\r\n" # https://docs.ruby-lang.org/ja/latest/method/IO/i/write.html
#     socket.write "\r\n"
#     socket.write "Hello World\r\n"
#     socket.close
#     break
#   end
# end

# 3rd step: analyze request
# if match = socket.gets.chomp.match(/^(?<verb>[A-Z]*)(?<path>.[^ ]*)(?<ver>.*)$/) # GET /hello HTTP/1.1
#   headers = []
#   while line = socket.gets.chomp
#     break if line.bytesize == 0
#     headers << line.split(": ")
#   end

#   p VERB: match[:verb] # {:VERB=>"GET"}
#   p PATH: match[:path] # {:PATH=>" /hello"}
#   p VERSION: match[:ver] # {:VERSION=>" HTTP/1.1"}
#   p HEADERS: headers # {:HEADERS=>[["Host", "localhost:3000"], ["User-Agent", "curl/7.77.0"], ["Accept", "*/*"]]}

#   if line.bytesize == 0
#     socket.write "HTTP/1.1 200 OK\r\n" # https://docs.ruby-lang.org/ja/latest/method/IO/i/write.html
#     socket.write "\r\n"
#     socket.write "Hello World\r\n"
#     socket.close
#   end
# end