action :create do
  app = new_resource.app
  path = new_resource.path

  ["ini", "php", "shell"].each do |format|
    template "#{path}/.deploy_configuration.#{format}" do
      mode   "0644"
      cookbook "easybib"
      source "empty.erb"
      variables(
        :content => ::EasyBib::Config.get_configcontent(format, app, node)
      )
    end
  end

  new_resource.updated_by_last_action(true)

end
