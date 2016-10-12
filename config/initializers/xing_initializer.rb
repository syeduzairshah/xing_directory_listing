XING_CONFIG = YAML.load_file('/opt/xing/config.yml')[Rails.env]

XingApi::Client.configure do |config|
  config.consumer_key = XING_CONFIG['consumer_key']
  config.consumer_secret = XING_CONFIG['consumer_secret']
end