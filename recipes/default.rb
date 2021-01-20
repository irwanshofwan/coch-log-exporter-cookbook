#
# Cookbook:: coch-log-setup
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

directory node["coch_elasticsearch_exporter"]["dir"] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

# Download coch-elasticsearch-exporterbinary & unpack
ark ::File.basename(node["coch_elasticsearch_exporter"]["dir"]) do
  url node["coch_elasticsearch_exporter"]["binary_url"]
  checksum node["coch_elasticsearch_exporter"]["checksum"]
  version node["coch_elasticsearch_exporter"]["version"]
  prefix_root Chef::Config["file_cache_path"]
  path ::File.dirname(node["coch_elasticsearch_exporter"]["dir"])
  owner 'root'
  group 'root'
  action :put
  notifies :restart, "service[coch_elasticsearch_exporter]", :delayed
end

systemd_unit "coch_elasticsearch_exporter.service" do
  content <<~END_UNIT
            [Unit]
            Description=Conformance Checker Elastisearch Exporter
            After=network.target

            [Service]
            ExecStart=/bin/bash #{node["postgres_exporter"]["binary"]}
            Restart=on-failure

            [Install]
            WantedBy=default.target
            WantedBy=multi-user.target
          END_UNIT
  action %i(create enable)
  notifies :restart, "service[coch_elasticsearch_exporter]", :delayed
end

service "coch_elasticsearch_exporter" do
  action %i(enable start)
end
