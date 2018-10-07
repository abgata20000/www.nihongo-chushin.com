# frozen_string_literal: true

class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  # Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  #  username == ENV['SIDEKIQ_BASIC_USER'] && password == ENV['SIDEKIQ_BASIC_PASSWORD']
  # end
  # mount Sidekiq::Web => '/my-sidekiq'

  root to: "static_pages#top"
  get "vue_sample" => "static_pages#vue_sample"
  resources :samples

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
#                      root GET    /                                                                                        static_pages#top
#                vue_sample GET    /vue_sample(.:format)                                                                    static_pages#vue_sample
#                   samples GET    /samples(.:format)                                                                       samples#index
#                           POST   /samples(.:format)                                                                       samples#create
#                new_sample GET    /samples/new(.:format)                                                                   samples#new
#               edit_sample GET    /samples/:id/edit(.:format)                                                              samples#edit
#                    sample GET    /samples/:id(.:format)                                                                   samples#show
#                           PATCH  /samples/:id(.:format)                                                                   samples#update
#                           PUT    /samples/:id(.:format)                                                                   samples#update
#                           DELETE /samples/:id(.:format)                                                                   samples#destroy
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
#                 api_chats GET    /api/chats(.:format)                                                                     api/chats#show
#                           POST   /api/chats(.:format)                                                                     api/chats#create
#                  api_room GET    /api/room(.:format)                                                                      api/rooms#show
#           api_rooms_users GET    /api/rooms/users(.:format)                                                               api/rooms/users#index
#              api_my_pages GET    /api/my_pages(.:format)                                                                  api/my_pages#show
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
