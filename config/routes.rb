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
    delete 'leave'
  end
  resources :rooms, only: %w(new create show index edit update) do
    get 'join'
    get 'users'
    put 'owner_transfer'
    delete 'ban_user'
    delete 'drive_out_user'
    resources :room_passwords, only: %w(new create)
  end

  resources :chats, only: %w(create)
  resource :sessions, only: %w(create destroy)
  get 'signin', to: 'sessions#new'
  get 'sessions', to: 'sessions#new'
  #
  # draw :api
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
#                leave_room DELETE /room/leave(.:format)                                                                    rooms#leave
#                 room_join GET    /rooms/:room_id/join(.:format)                                                           rooms#join
#                room_users GET    /rooms/:room_id/users(.:format)                                                          rooms#users
#       room_owner_transfer PUT    /rooms/:room_id/owner_transfer(.:format)                                                 rooms#owner_transfer
#             room_ban_user DELETE /rooms/:room_id/ban_user(.:format)                                                       rooms#ban_user
#       room_drive_out_user DELETE /rooms/:room_id/drive_out_user(.:format)                                                 rooms#drive_out_user
#       room_room_passwords POST   /rooms/:room_id/room_passwords(.:format)                                                 room_passwords#create
#    new_room_room_password GET    /rooms/:room_id/room_passwords/new(.:format)                                             room_passwords#new
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
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
