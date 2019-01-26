require 'resolv'
require 'redis'
 
while true
  dnses = ["172.28.128.1", "172.28.128.11", "172.28.128.12"]
  checked_dnses = []
  dnses.each do |d|
    dns = Resolv::DNS.new(:nameserver_port=>[[d,8600]])
    dns.timeouts = 1
    ret = dns.getresources("consul.service.consul", Resolv::DNS::Resource::IN::SRV) rescue nil
    if ret && !ret.empty?
      checked_dnses << d
    else
    end
  end
  redis = Redis.new(url: "redis://172.28.128.11:5700")
  redis.set("dnses", checked_dnses.join(","))
  puts Time.now.to_s + ': ' + checked_dnses.inspect
  sleep 1
end

