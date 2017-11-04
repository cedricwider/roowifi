require 'http'
require 'json'

module Roowifi
  class Roomba

    BUTTON_MAPPING = {
      clean: 4,
      spot:  5,
      dock:  6,
      idle:  1
    }.freeze

    def initialize(ip:, user: 'admin', pass: 'roombawifi')
      @ip     = ip
      @client = HTTP.basic_auth(user: user, pass: pass)
    end

    def dock
      click_button(:dock)
    end

    def clean
      click_button(:clean)
    end

    def spot
      click_button(:spot)
    end

    def stop
      click_button(:idle)
    end

    def status
      json_body = client.get("http://#{ip}/roomba.json").body.to_s
      Status.new(JSON.parse json_body)
    end

    private

    attr_reader :ip, :client

    def click_button(button)
      client.get("http://#{ip}/rwr.cgi?exec=#{BUTTON_MAPPING[button]}")
    end
  end
end
