include_recipe 'php-fpm::service'

include_recipe 'apt::ppa'
include_recipe 'apt::easybib'

package 'php5-easybib-zlib' do
  notifies :reload, 'service[php-fpm]', :delayed
end
