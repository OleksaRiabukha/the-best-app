Sentry.init do |config|
  config.dsn = 'https://f91888f8073249a9bfdac4325d31cbab@o998368.ingest.sentry.io/5957092'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.traces_sampler = lambda do |context|
    true
  end
end
