require 'unit/spec_helper'

describe 'sprout-bash-it::default' do
  let(:runner) { ChefSpec::Runner.new }

  it 'clones the git repository into the chef cache directory' do
    runner.converge(described_recipe)
    expect(runner).to sync_git("#{Chef::Config[:file_cache_path]}/bash_it")
      .with(repository: runner.node['sprout']['bash_it']['repository'])
  end

  it 'includes the custom_plugins recipe' do
    runner.converge(described_recipe)
    expect(runner).to include_recipe('sprout-bash-it::custom_plugins')
  end

  it 'includes the enabled_feature recipe' do
    runner.converge(described_recipe)
    expect(runner).to include_recipe('sprout-bash-it::enabled_plugins')
  end

  it 'copies in a .bash_profile to user home' do
    runner.converge(described_recipe)
    expect(runner).to create_template(::File.expand_path('.bash_profile', runner.node['sprout']['home']))
      .with(owner: runner.node['sprout']['user'])
  end

  context 'when the git repository is specified' do
    it 'syncs that git repository' do
      custom_git_repo = 'https://github.com/hjhart/whatever-this-may-be.git'
      runner.node.set['sprout']['bash_it']['repository'] = custom_git_repo
      runner.converge(described_recipe)
      expect(runner).to sync_git("#{Chef::Config[:file_cache_path]}/bash_it").with(repository: custom_git_repo)
    end
  end

  context 'when the directory is specified' do
    it 'creates the bash_it directory, as specified' do
      runner.node.set['sprout']['bash_it']['dir'] = '/Users/hjhart/.bash_it'
      runner.converge(described_recipe)
      expect(runner).to create_directory('/Users/hjhart/.bash_it')
    end
  end

  context 'when the theme is specified' do
    it 'passes the theme as a variable to the bashrc template' do
      runner.node.set['sprout']['bash_it']['theme'] = 'wanelo'
      runner.node.set['sprout']['bash_it']['dir'] = '/Users/wanelo/bash_it'
      runner.converge(described_recipe)
      expected_variables = { variables: { bash_it_dir: '/Users/wanelo/bash_it', bash_it_theme: 'wanelo' } }
      expect(runner).to create_template('/home/fauxhai/.bash_profile').with(expected_variables)
    end
  end

  context 'when the bashrc_path attribute is set' do
    it 'creates that file where specified' do
      runner.node.set['sprout']['bash_it']['bashrc_path'] = '/Users/hjhart/.hjhart_bash_profile'
      runner.converge(described_recipe)
      expect(runner).to create_template('/Users/hjhart/.hjhart_bash_profile').with(owner: runner.node['current_user'])
    end
  end
end
