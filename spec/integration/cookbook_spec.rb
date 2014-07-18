require 'spec_helper'

describe 'sprout-bash-it::default' do
  before :all do
    expect(File).not_to be_exists("#{ENV['HOME']}/.bash_it")
    expect(File).not_to be_exists("#{ENV['HOME']}/.bash_profile")
    expect(system('soloist')).to eq(true)
  end

  it 'creates the .bash_it directory in the home directory' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it")
  end

  it 'creates a .bash_profile' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_profile")
  end

  it 'creates custom plugins' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it/custom/disable_ctrl-s_output_control.bash")
  end

  it 'creates enabled aliases' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it/aliases/enabled/general.aliases.bash")
  end

  it 'creates enabled completions' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it/completion/enabled/git.completion.bash")
  end

  it 'creates enabled plugins' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it/plugins/enabled/ssh.plugin.bash")
  end
end
