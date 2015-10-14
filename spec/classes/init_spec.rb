require 'spec_helper'
describe 'jerakia' do

  context 'with defaults for all parameters' do
    it { should contain_class('jerakia') }
  end
end
