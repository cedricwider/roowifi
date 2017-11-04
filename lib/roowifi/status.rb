module Roowifi
  class Status
    MAPPING = {
      bumps_wheeldrops:    0,
      wall:                1,
      cliff_left:          2,
      cliff_front_left:    3,
      cliff_front_right:   4,
      cliff_right:         5,
      virtual_wall:        6,
      dirt_detector_left:  8,
      dirt_detector_right: 9,
      remote_opcode:       10,
      button:              11,
      distance:            12,
      angle:               13,
      charging_state:      14,
      voltage:             15,
      current:             16,
      temperature:         17,
      charge:              18,
      capacity:            19
    }.freeze

    def initialize(values)
      @values = values
    end

    def wall?
      wall != 0
    end

    def charging?
      charging_state == 2
    end

    def battery_level
      ((100 / capacity.to_f) * charge.to_f).to_i
    end

    def method_missing(method, *args)
      super(method, *args) unless MAPPING.key?(method)
      value(MAPPING[method])&.to_i
    end

    private

    attr_reader :values

    def value(id)
      values.dig('response', "r#{id}", 'value')
    end
  end
end
