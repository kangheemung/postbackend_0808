Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # or specify your allowed origins here

      resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
    end
  end
  