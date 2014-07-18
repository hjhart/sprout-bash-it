node['bash_it']['enabled_plugins'].each do |feature_type, features|
  features.each do |feature_name|
    sprout_bash_it_enable_feature "#{feature_type}/#{feature_name}"
  end
end
