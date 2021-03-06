Chef::Resource.send(:include, NodeJs::Helper)

node.force_override['nodejs']['npm']['install_method'] = 'from_latest'

npm_bin = '/usr/bin/npm'

local_latest = "#{Chef::Config[:file_cache_path]}/install-npm.sh"

npm_version = node['nodejs']['npm']['version']

remote_file local_latest do
  source 'https://www.npmjs.org/install.sh'
  mode '0755'
  not_if do
    npm_package_installed?('npm', node['nodejs']['npm']['version'])
  end
end

package "curl" do
  action :install
  only_if do
    File.exist?(local_latest)
  end
end

execute 'Install npm' do
  command local_latest
  environment({
    'clean' => 'no',
    'npm_install' => npm_version
  })
  not_if do
    npm_package_installed?('npm', node['nodejs']['npm']['version'])
  end
end
