bash_it_version = version_string_for('bash_it')
bash_it_dir = node['sprout']['bash_it']['dir']

git "#{Chef::Config[:file_cache_path]}/bash_it" do
  repository node['sprout']['bash_it']['repository']
  revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/bash_it"
  action :sync
end

directory bash_it_dir do
  owner node['current_user']
  mode '0777'
end

execute "Copying bash-it's .git to #{node['bash_it']['dir']}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/bash_it/ #{bash_it_dir}"
  user node['current_user']
end

template node['sprout']['bash_it']['bashrc_path'] do
  source 'bash_it/bashrc.erb'
  cookbook 'sprout-base'
  owner node['current_user']
  mode '0777'
end

include_recipe 'sprout-bash-it::custom_plugins'
include_recipe 'sprout-bash-it::enabled_plugins'
