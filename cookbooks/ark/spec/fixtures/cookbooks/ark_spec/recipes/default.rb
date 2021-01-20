apt_update 'update'

include_recipe 'ark'

# remove file so we can test sending notification on its creation
FileUtils.rm_f '/tmp/foobarbaz/foo1.txt' if ::File.exist? '/tmp/foobarbaz/foo1.txt'

ruby_block 'test_notification' do
  block do
    FileUtils.touch '/tmp/foobarbaz/notification_successful.txt' if ::File.exist? '/tmp/foobarbaz/foo1.txt'
  end
  action :nothing
end

group 'foobarbaz_group'

user 'foobarbaz' do
  group 'foobarbaz_group'
end

directory '/opt/bin' do
  recursive true
end

ark 'foo' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  version '2'
  prefix_root '/usr/local'
  owner 'foobarbaz'
  group 'foobarbaz_group'
  has_binaries ['bin/do_foo', 'bin/do_more_foo']
  action :install
end

ark 'test_put' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  owner 'foobarbaz'
  group 'foobarbaz_group'
  action :put
end

ark 'test_dump' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.zip'
  checksum 'deea3a324115c9ca0f3078362f807250080bf1b27516f7eca9d34aad863a11e0'
  path '/usr/local/foo_dump'
  creates 'foo1.txt'
  owner 'foobarbaz'
  group 'foobarbaz_group'
  action :dump
end

ark 'cherry_pick_test' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  path '/usr/local/foo_cherry_pick'
  owner 'foobarbaz'
  group 'foobarbaz_group'
  creates 'foo_sub/foo1.txt'
  action :cherry_pick
end

ark 'cherry_pick_with_zip' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.zip'
  checksum 'deea3a324115c9ca0f3078362f807250080bf1b27516f7eca9d34aad863a11e0'
  path '/usr/local/foo_cherry_pick_from_zip'
  creates 'foo_sub/foo1.txt'
  action :cherry_pick
end

ark 'foo_append_env' do
  version '7.0.26'
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  append_env_path true
  action :install
end

ark 'foo_dont_strip' do
  version '2'
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  strip_components 0
  action :install
end

ark 'foo_zip_strip' do
  version '2'
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.zip'
  checksum 'deea3a324115c9ca0f3078362f807250080bf1b27516f7eca9d34aad863a11e0'
  action :install
end

ark 'haproxy' do
  url 'http://haproxy.1wt.eu/download/1.5/src/snapshot/haproxy-ss-20120403.tar.gz'
  version '1.5'
  checksum 'ba0424bf7d23b3a607ee24bbb855bb0ea347d7ffde0bec0cb12a89623cbaf911'
  make_opts ['TARGET=linux26']
  action :install_with_make
end unless platform?('freebsd')

ark 'foo_alt_bin' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tar.gz'
  checksum '5996e676f17457c823d86f1605eaa44ca8a81e70d6a0e5f8e45b51e62e0c52e8'
  version '3'
  prefix_root '/opt'
  prefix_home '/opt'
  prefix_bin '/opt/bin'
  owner 'foobarbaz'
  group 'foobarbaz_group'
  has_binaries ['bin/do_foo']
  action :install
end

ark 'foo_tbz' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tbz'
  version '3'
end

ark 'foo_tgz' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.tgz'
  version '3'
end

ark 'foo_txz' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.txz'
  version '3'
  # tar is too old in CENTOS < 6 (1.15.1 needs > 1.22)
  not_if { platform?('centos') && node['platform_version'].to_f < 6.0 }
end

ark 'test_notification' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo.zip'
  path '/tmp/foobarbaz'
  creates 'foo1.txt'
  action :dump
  notifies :create, 'ruby_block[test_notification]', :immediately
end

ark 'test_autogen' do
  url 'http://zlib.net/zlib-1.2.11.tar.gz'
  extension 'tar.gz'
  action :configure
end

ark 'foo_sub_tar' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo_sub.tar.gz'
  version '1'
  strip_components 2
end

ark 'foo_sub_zip' do
  url 'https://github.com/burtlo/ark/raw/master/files/default/foo_sub.zip'
  version '2'
  strip_components 2
end
