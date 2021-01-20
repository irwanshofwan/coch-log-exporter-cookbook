default["coch_elasticsearch_exporter"]["dir"] = '/opt/conformance-checker-elasticalert-exporter'
default["coch_elasticsearch_exporter"]["binary"] = "#{node["coch_elasticsearch_exporter"]["dir"]}/bin"
default["coch_elasticsearch_exporter"]["version"] = "0.1.0"
default["coch_elasticsearch_exporter"]["checksum"] = "dfb7529bc38658ed3c682ef3d55012c475acadf3f2793906bbf5dd9624188cac"
default["coch_elasticsearch_exporter"]["binary_url"] = "https://github.com/ralibi/coch-log-exporter/releases/download/v#{node["coch_elasticsearch_exporter"]["version"]}/coch-log-exporter_#{node["coch_elasticsearch_exporter"]["version"]}_Linux_x86_64.tar.gz"


#default["coch_elasticsearch_exporter"]["binary_url"] = "https://github.com//releases/download/golang-echo-example/archive/#{node["coch_elasticsearch_exporter"]["version"]}.zip"
#default["coch_elasticsearch_exporter"]["binary_url"] = "https://github.com/irwanshofwan/golang-echo-example/releases/download/v#{node["coch_elasticsearch_exporter"]["version"]}/coch_elasticsearch_exporter-#{node["coch_elasticsearch_exporter"]["version"]}.linux-amd64.tar.xz"
