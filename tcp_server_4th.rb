require "socket"
require "./application.rb"

port = 3000
server = TCPServer.new(port) # [TCPServer]

# Wait for connection
socket = server.accept # [TCPSocket]
puts "Got a connection!"

if match = socket.gets.chomp.match(/^(?<verb>[A-Z]*)(?<path>.[^ ]*)(?<ver>.*)$/) # GET /hello HTTP/1.1
  # Make a hash with the request information
  env = {
    "REQUEST_METHOD" => match[:verb],
    "PATH_INFO" => match[:path],
    "HTTP_VERSION" => match[:ver],
  }

  while line = socket.gets.chomp
    break if line.bytesize == 0
    key, value = line.split(": ")
    env[key] = value
  end

  # call app with request information
  app = Application.new
  response = app.call(env)

  status = response[0]
  headers = response[1]
  body = response[2]

  socket.write "HTTP/1.1 #{status} OK\r\n"

  headers.each do |key, value|
    socket.write "#{key}: #{value}"
  end

  socket.write "\r\n"

  body.each do |part|
    socket.write part
  end

  socket.close
else
  socket.close
end