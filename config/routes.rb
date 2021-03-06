# frozen_string_literal: true
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
   username == ENV['SIDEKIQ_BASIC_USER'] && password == ENV['SIDEKIQ_BASIC_PASSWORD']
  end
  mount Sidekiq::Web, at: "/my-sidekiq"

  root to: "static_pages#top"
  get "vue_sample" => "static_pages#vue_sample"
  get "sample" => "static_pages#sample"
  get "like_line" => "static_pages#like_line"

  resource :my_pages, only: %w(show update)
  resource :room, only: %w() do
    scope module: :rooms do
      resource :leaves, only: %w(destroy)
    end
  end
  resources :rooms, only: %w(new create show index edit update) do
    scope module: :rooms do
      resources :users, only: %w(index)
      resource :joins, only: %w(show)
      resource :passwords, only: %w(new create)
      resources :owner_transfers, only: %w(update)
      resources :ban_users, only: %w(destroy)
      resources :drive_out_users, only: %w(destroy)
    end
  end

  resources :chats, only: %w(create)
  resource :sessions, only: %w(create destroy)
  get 'signin', to: 'sessions#new'
  get 'sessions', to: 'sessions#new'
  #
  draw :api
  # draw :admins
end

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#               sidekiq_web        /my-sidekiq                                                                              Sidekiq::Web
#                      root GET    /                                                                                        static_pages#top
#                vue_sample GET    /vue_sample(.:format)                                                                    static_pages#vue_sample
#                    sample GET    /sample(.:format)                                                                        static_pages#sample
#                 like_line GET    /like_line(.:format)                                                                     static_pages#like_line
#                  my_pages GET    /my_pages(.:format)                                                                      my_pages#show
#                           PATCH  /my_pages(.:format)                                                                      my_pages#update
#                           PUT    /my_pages(.:format)                                                                      my_pages#update
#               room_leaves DELETE /room/leaves(.:format)                                                                   rooms/leaves#destroy
#                room_users GET    /rooms/:room_id/users(.:format)                                                          rooms/users#index
#                room_joins GET    /rooms/:room_id/joins(.:format)                                                          rooms/joins#show
#        new_room_passwords GET    /rooms/:room_id/passwords/new(.:format)                                                  rooms/passwords#new
#            room_passwords POST   /rooms/:room_id/passwords(.:format)                                                      rooms/passwords#create
#       room_owner_transfer PATCH  /rooms/:room_id/owner_transfers/:id(.:format)                                            rooms/owner_transfers#update
#                           PUT    /rooms/:room_id/owner_transfers/:id(.:format)                                            rooms/owner_transfers#update
#             room_ban_user DELETE /rooms/:room_id/ban_users/:id(.:format)                                                  rooms/ban_users#destroy
#       room_drive_out_user DELETE /rooms/:room_id/drive_out_users/:id(.:format)                                            rooms/drive_out_users#destroy
#                     rooms GET    /rooms(.:format)                                                                         rooms#index
#                           POST   /rooms(.:format)                                                                         rooms#create
#                  new_room GET    /rooms/new(.:format)                                                                     rooms#new
#                 edit_room GET    /rooms/:id/edit(.:format)                                                                rooms#edit
#                      room GET    /rooms/:id(.:format)                                                                     rooms#show
#                           PATCH  /rooms/:id(.:format)                                                                     rooms#update
#                           PUT    /rooms/:id(.:format)                                                                     rooms#update
#                     chats POST   /chats(.:format)                                                                         chats#create
#                  sessions DELETE /sessions(.:format)                                                                      sessions#destroy
#                           POST   /sessions(.:format)                                                                      sessions#create
#                    signin GET    /signin(.:format)                                                                        sessions#new
#                           GET    /sessions(.:format)                                                                      sessions#new
#                 api_chats GET    /api/chats(.:format)                                                                     api/chats#index
#                           POST   /api/chats(.:format)                                                                     api/chats#create
#                  api_room GET    /api/room(.:format)                                                                      api/rooms#show
#           api_rooms_users GET    /api/rooms/users(.:format)                                                               api/rooms/users#index
#               api_my_page GET    /api/my_page(.:format)                                                                   api/my_pages#show
#           api_v1_sessions GET    /api/v1/sessions(.:format)                                                               api/v1/sessions#show
#                           DELETE /api/v1/sessions(.:format)                                                               api/v1/sessions#destroy
#                           POST   /api/v1/sessions(.:format)                                                               api/v1/sessions#create
#              api_v1_rooms GET    /api/v1/rooms(.:format)                                                                  api/v1/rooms#index
#                           POST   /api/v1/rooms(.:format)                                                                  api/v1/rooms#create
#               api_v1_room PATCH  /api/v1/rooms/:id(.:format)                                                              api/v1/rooms#update
#                           PUT    /api/v1/rooms/:id(.:format)                                                              api/v1/rooms#update
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
