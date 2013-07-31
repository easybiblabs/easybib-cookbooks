include_recipe "redis::service"

template "/etc/default/redis" do
  source "default.erb"
  mode "0644"
  notifies :restart, resources( :service => "redis-server")
end

directory "/etc/redis" do
  user node["redis"]["user"]
  mode "0755"
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  owner  node["redis"]["user"]
  mode   "0644"
  notifies :restart, resources(:service => "redis-server"), :immediately
end

template "/etc/logrotate.d/redis" do
  source "logrotate.erb"
  mode "0644"
  owner "root"
  group "root"
end
