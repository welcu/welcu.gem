module Welcu
  class Config < Hashie::Mash
  end

  def self.config
    @config ||= Welcu::Config.new({
      :api_uri => 'https://backstage.welcu.com',
      :api_path => '/api/v1'
    })
  end
end
