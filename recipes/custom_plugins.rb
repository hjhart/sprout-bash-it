node['bash_it']['custom_plugins'].each do |cookbook_name, custom_plugins|
  custom_plugins.each do |custom_plugin|
    sprout_bash_it_custom_plugin custom_plugin do
      cookbook cookbook_name
    end
  end
end
