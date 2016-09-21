require 'spec_helper'
describe 'jerakia' do

  context 'with defaults for all parameters' do
    it { should compile }
    it { should contain_class('jerakia') }
  end
end
