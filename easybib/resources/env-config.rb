actions :create

default_action :create

attribute :app, :required => true, :name_attribute => true
attribute :deploy_data, :required => true
attribute :path, :kind_of => String, :default => nil
