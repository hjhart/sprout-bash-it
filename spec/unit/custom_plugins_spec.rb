require 'unit/spec_helper'

describe 'sprout-bash-it::custom_plugins' do
  let(:runner) { ChefSpec::Runner.new }

  # Apparently it is very difficult to test LWRP w/ ChefSpec when your
  # cookbook name has hyphens in it. Perhaps we should consider changing cookbook names
  # to use underscores instead of dashes.
  xit 'creates a template for custom plugins' do
    runner.node.set['sprout']['bash_it'] = {
      'custom_plugins' => { 'sprout-bash-it' => ['bash_it/custom/something.bash'] },
      'dir' => '/Users/wanelo/.bash_it'
    }

    runner.converge(described_recipe)
    custom_plugin_path = File.join(runner.node['sprout']['bash_it']['dir'], 'custom', 'something.bash')
    expect(runner).to create_template(custom_plugin_path)
  end
end
