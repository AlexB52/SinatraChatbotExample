require 'facebook/messenger'
require 'dotenv/load'
require 'sinatra'
require 'recastai'
require 'restcountry'

get '/webhook' do
  params['hub.challenge'] if ENV["VERIFY_TOKEN"] == params['hub.verify_token']
end

get "/" do
  "Nothing to see here"
end
