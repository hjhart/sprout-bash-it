require 'unit/spec_helper'

describe 'sprout-bash-it::custom_plugins' do
  let(:runner) { ChefSpec::Runner.new }

  xit 'creates a template for custom plugins' do
    runner.node.set['bash_it'] = {
      'custom_plugins' => { 'sprout-bash-it' => ['bash_it/custom/something.bash'] },
      'dir' => '/Users/wanelo/.bash_it'
    }

    runner.converge(described_recipe)
    custom_plugin_path = File.join(runner.node['bash_it']['dir'], 'custom', 'something.bash')
    expect(runner).to create_template(custom_plugin_path)
  end
end
