
if Rails.env === 'production'
    Rails.application.config.session_store :cookie_store, key: '_cookie_key', domain: 'http://52.195.43.116:3000'
else
    Rails.application.config.session_store :cookie_store, key: '_cookie_key'
end
