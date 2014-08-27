require_relative "spec_helper"

describe 'nginx-app::getcourse-api' do

  let(:cookbook_paths) do
    [
      File.expand_path("#{File.dirname(__FILE__)}/../../")
    ]
  end

  let(:runner)   { ChefSpec::Runner.new(:cookbook_path => cookbook_paths) }
  let(:chef_run) { runner.converge("nginx-app::getcourse-api") }
  let(:node)     { runner.node }

  let(:cache_config_file) { "/etc/nginx/conf.d/cache.conf" }
  let(:nginx_config_file) { "/etc/nginx/sites-enabled/api.conf" }

  describe "fastcgi cache is enabled" do
    before do
      node.set["nginx-app"]["cache"] = {
        "enabled" => true,
        "zone" => "CHEFSPEC_TEST"
      }

      node.set["vagrant"] = {
        "deploy_to" => "/foo/bar"
      }
      node.set["getcourse"]["domain"] = {
        "api" => "api.example.org"
      }
    end

    it "does render the cache.conf" do
      expect(chef_run).to render_file(cache_config_file)
    end

    it "does enable the fastcgi cache" do
      expect(chef_run).to render_file(nginx_config_file)
        .with_content(
          include("fastcgi_cache #{node["nginx-app"]["cache"]["zone"]};")
        )
    end
  end

  describe "fastcgi cache is not enabled" do
    before do
      node.set["vagrant"] = {
        "deploy_to" => "/foo/bar"
      }
      node.set["getcourse"]["domain"] = {
        "api" => "api.example.org"
      }
    end

    it "does not render cache.conf" do
      expect(chef_run).not_to render_file(cache_config_file)
    end

    it "does not enable the fastcgi cache" do
      expect(chef_run).not_to render_file(nginx_config_file)
        .with_content(
          include("fastcgi_cache #{node["nginx-app"]["cache"]["zone"]};")
        )
    end

  end
end