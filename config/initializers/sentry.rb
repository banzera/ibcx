Sentry.init do |config|
  # config.dsn = 'https://examplePublicKey@o0.ingest.sentry.io/0'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  # config.traces_sample_rate = 0.5

  config.delayed_job.report_after_job_retries = true

  config.backtrace_cleanup_callback = lambda do |backtrace|
    Rails.backtrace_cleaner.clean(backtrace)
  end

  config.excluded_exceptions << [
    "Rack::Timeout::RequestTimeoutException",
  ]
end
