require 'spec_helper'

describe Roowifi::Roomba do
  subject { described_class.new(ip: '10.0.0.1', user: 'rspec', pass: 'password') }

  it 'is initialized with an IP' do
    expect(subject).to be
  end

  context 'basic controls' do
    let(:dock_request) do
      stub_request(:get, 'http://10.0.0.1/rwr.cgi?exec=6')
        .to_return(status: 200, body: '1')
    end

    let(:clean_request) do
      stub_request(:get, 'http://10.0.0.1/rwr.cgi?exec=4')
        .to_return(status: 200, body: '1')
    end

    before(:each) do
      dock_request
      clean_request
    end

    it 'can dock' do
      subject.dock
      expect(dock_request).to have_been_requested
    end

    it 'can clean' do
      subject.clean
      expect(clean_request).to have_been_requested
    end
  end
end
