require 'spec_helper'
require 'json'

describe Roowifi::Status do
  subject { described_class.new(JSON.parse response) }

  let(:response) do
    <<-EOF
    {
      "response": {
        "r18": {
          "name": "Charge",
          "value": "1549"
        },
        "r19": {
          "name": "Capacity",
          "value": "2696"
        }
      }
    }
    EOF
  end

  it 'reads battery level' do
    expect(subject.battery_level).to eq 57
  end

  context 'dynamic values' do
    let(:response) {File.read('./spec/fixtures/status_response.json')}

    it '#temperature' do
      expect(subject.temperature).to eq 40
    end

    it '#charging?' do
      expect(subject.charging?).to be true
    end
  end
end
