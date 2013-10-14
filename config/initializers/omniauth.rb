Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load_file("#{Rails.root}/config/omniauth.yml")

  # twitter setting
  twitter_conf = config[Rails.env]["twitter"]
  twitter_options = {}
  twitter_options = { client_options: { proxy: twitter_conf["proxy"] } } if twitter_conf["proxy"].present?
  provider :twitter, twitter_conf["consumer_key"], twitter_conf["consumer_secret"] , twitter_options

  # facebook setting
  facebook_conf = config[Rails.env]["facebook"]
  facebook_options = {}
  facebook_options = { client_options: { connection_opts: { proxy: facebook_conf["proxy"] } } } if facebook_conf["proxy"].present?
  facebook_options.merge!({ scope: facebook_conf["scope"] })
  provider :facebook, facebook_conf["consumer_key"], facebook_conf["consumer_secret"], facebook_options
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
