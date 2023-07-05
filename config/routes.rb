# frozen_string_literal: true

Rails.application.routes.draw do
  post '/events', to: 'events#create'
  get '/reports/:employee_id/:from/:to' => 'reports#get'
end
