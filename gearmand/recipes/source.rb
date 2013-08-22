# WIP to document source install of gearmand

package "gearman-job-server" do
  action :purge
end

prefix = node['gearmand']['prefix']
version = node['gearmand']['source']['version']

directory prefix do
  mode "0755"
end

["libboost-all-dev", "gperf", "libevent1-dev", "libcloog-ppl0", "make"].each do |dep|
  package dep
end

remote_file "/tmp/gearmand-#{version}.tar.gz" do
  source node['gearmand']['source']['link']
  checksum node['gearmand']['source']['hash']
end

execute "tar -zxvf /tmp/gearmand-#{version}.tar.gz" do
  cwd "/tmp"
end


commands = [
  "./configure --prefix=#{prefix}/#{version} #{node['gearmand']['source']['flags']}",
  "make",
  "make install"
]

commands.each do |command|
  execute "Running #{command}" do
    command command
    cwd "/tmp/gearmand-#{version}/"
    not_if do
      File.exists?("#{prefix}/#{version}/sbin/gearmand")
    end
  end
end

include_recipe "gearmand::configure"
