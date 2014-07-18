require 'unit/spec_helper'

describe 'sprout-bash-it::default' do
  let(:runner) { ChefSpec::Runner.new }

  it 'clones the git repository into the chef cache directory' do
    runner.converge(described_recipe)
    expect(runner).to sync_git("#{Chef::Config[:file_cache_path]}/bash_it")
  end
  context 'when the directory is specified' do
    let(:runner) {
      ChefSpec::Runner.new do |node|
        node.set['bash_it']['dir'] = '/Users/hjhart/.bash_it'
      end
    }

    it 'creates the bash_it directory, as specified' do
      runner.converge(described_recipe)
      expect(runner).to create_directory('/Users/hjhart/.bash_it')
    end
  end
end
