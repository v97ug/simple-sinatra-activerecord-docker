require 'sinatra/base'
require 'mysql2'
require 'mysql2-cs-bind'
require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class User < ActiveRecord::Base
end

class MyApp < Sinatra::Base
  set :bind, '0.0.0.0'

  get '/' do
    'hello sinatra!!'
  end

  get '/all-user' do
    users = User.all
    users.to_json
  end

  post '/user' do
    # json = JSON.parse(request.body.read)
    user = User.new
    user.name = 'user-name'
    user.created_at = Time.now
    user.save
    user.to_json
  end

  run! if app_file == $0
end