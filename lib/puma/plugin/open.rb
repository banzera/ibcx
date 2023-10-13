require "puma/plugin"

Puma::Plugin.create do
  def start(launcher)
    return unless defined?(Rails) && defined?(Launchy)
    return unless Rails.env.development?

    host = ENV['DEVELOPMENT_HOST']
    return if host.nil?

    url = URI::HTTPS.build(host: host)
    Launchy.open(url)
  end
end
