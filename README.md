**Virtual-Domain** provides an easy configure for a virtual host/domain accessible for all interal-network users.

I start a web service using 

```
rails server -p 3000
```

I want to access the web in browser through a domain(`http://local.test.com`) instead of `http://localhost:3000`. I also want the domain name available for internal-network users. 


## Usage

1. Start your web service. For example `php -S 0.0.0.0:8080` or `rails server -p 3000`
2. Start the dns server and port forwarding server. (Will be wraped up as one service in the future)
```
ruby dns.rb 
```
```
ruby port_forwarding.rb 3000
```
3. Add `0.0.0.0` to local DNS servers
4. Access the web service through `http://local.test.com`
