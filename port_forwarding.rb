require 'socket'
require 'readline'

def server(remote_port)
  begin
    rport_server = TCPServer.new('0.0.0.0', 80)
		while true 
      rport_client = rport_server.accept
      lport_server = TCPSocket.new('0.0.0.0', remote_port)
      Thread.new { forward(rport_client, lport_server) }
      Thread.new { forward(lport_server, rport_client) }
    end
  rescue Exception => exception
  	puts 'Exiting'
	  rport_server.close  if rport_server
    lport_server.close  if lport_server
  end  
end

def forward(src, dst)
  while true 
    data = src.recv(1024)
    if data.length == 0
			break
		end
		dst.send(data, 0) unless data.empty?
  end
	src.shutdown Socket::SHUT_RDWR
	dst.shotdown Socket::SHUT_RDWR

	src.close
	dst.close
end

server(ARGV[0])
