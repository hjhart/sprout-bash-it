require 'spec_helper'

describe 'sprout-bash-it::default' do
  before :all do
    expect(File).not_to be_exists("#{ENV['HOME']}/.bash_it")
    expect(system('soloist')).to eq(true)
  end

  it 'creates the .bash_it directory in the home directory' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_it")
  end

  it 'creates a .bash_profile' do
    expect(File).to be_exists("#{ENV['HOME']}/.bash_profile")
  end
end
