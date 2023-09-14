Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://18.176.21.52:3000' # or specify your allowed origins here
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Access-Token', 'Expiry', 'Token-Type', 'Uid', 'Client'], # use string values instead of symbols
      credentials: true
  end
end
