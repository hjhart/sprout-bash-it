bash_it_version = version_string_for('bash_it')
bash_it_config = node['sprout']['bash_it']
bash_it_dir = bash_it_config['dir']

git "#{Chef::Config[:file_cache_path]}/bash_it" do
  repository bash_it_config['repository']
  revision bash_it_version
  destination "#{Chef::Config[:file_cache_path]}/bash_it"
  action :sync
end

directory bash_it_dir do
  owner node['sprout']['user']
  mode '0777'
end

execute "Copying bash-it's .git to #{node['bash_it']['dir']}" do
  command "rsync -axSH #{Chef::Config[:file_cache_path]}/bash_it/ #{bash_it_dir}"
  user node['sprout']['user']
end

template bash_it_config['bashrc_path'] do
  source 'bash_it/bashrc.erb'
  cookbook 'sprout-bash-it'
  owner node['sprout']['user']
  variables bash_it_dir: bash_it_dir, bash_it_theme: bash_it_config['theme']
  mode '0777'
end

include_recipe 'sprout-bash-it::custom_plugins'
include_recipe 'sprout-bash-it::enabled_plugins'
