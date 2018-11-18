require 'rack-proxy'
require 'resolv'
require 'redis'

REDIS_URL = "172.28.128.11:5700"

class AppProxy < Rack::Proxy
  def rewrite_env(env)
  	#raise env.inspect
    server_name =      parse_request(Rack::Request.new(env))
    subdomain =        parse_subdomain(server_name)
    checked_dnses =    check_dnses()
    env["HTTP_HOST"] = get_backend(subdomain, checked_dnses)
    env
  end # rewrite_env

  private
   
  def parse_request(request)
    server_name = request.env["SERVER_NAME"]
    if !!(server_name =~ Resolv::IPv4::Regex) then
      raise "!: IP provided, domain expected"
    end
    return server_name 
  end # parse_request

  def parse_subdomain(server_name)
    subdomain = server_name.split(".")[0] rescue nil
    if subdomain.nil? then
      raise "!: no subdomain pointing at service"
    end
    return subdomain
  end # parse_subdomain

  def check_dnses()
    redis = Redis.new(url: "redis://#{REDIS_URL}")
    checked_dnses = redis.get("dnses").split(",")
    if checked_dnses.size == 0 then
      raise "!: no DNS available"
    end
    return checked_dnses
  end # check_dnses

  def get_backend(subdomain, checked_dnses)
    hosts = []
    backends = []
    dns = Resolv::DNS.new(:nameserver_port=>[[checked_dnses.sample,8600]])
    dns.timeouts = 2
    dns.getresources("#{subdomain}.service.consul", Resolv::DNS::Resource::IN::SRV).each do |h|
      #puts h.inspect
      hosts << [h.target.to_s, h.port]
    end
    hosts.each do |h| 
      addr = dns.getresources(h[0], Resolv::DNS::Resource::IN::ANY)
      #puts addr.inspect
      backends << addr[0].address.to_s + ":" + h[1].to_s
    end
    if backends.empty? then
      raise "!: no backend available"
    end
    return backends.sample
  end # get_backend
end
