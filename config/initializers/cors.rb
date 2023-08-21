Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://52.195.43.116:3000' # or specify your allowed origins here
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Access-Token', 'Expiry', 'Token-Type', 'Uid', 'Client'], # use string values instead of symbols
      credentials: true
  end
end
