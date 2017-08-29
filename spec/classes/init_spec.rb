require 'spec_helper'
describe 'ncpa' do
  context 'with default values for all parameters' do
    it { should contain_class('ncpa') }
  end
end
