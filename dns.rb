require 'rubydns'

INTERFACES = [
	[:udp, "0.0.0.0", 53],
	[:tcp, "0.0.0.0", 53],
]

IN = Resolv::DNS::Resource::IN
UPSTREAM = RubyDNS::Resolver.new([[:udp, "8.8.8.8", 53], [:tcp, "8.8.8.8", 53]])

RubyDNS::run_server(INTERFACES) do
	match(%r{local.test.com}, IN::A) do |transaction|
		transaction.respond!("127.0.0.1")
	end
	
	# Default DNS handler
	otherwise do |transaction|
		transaction.passthrough!(UPSTREAM)
	end
end
