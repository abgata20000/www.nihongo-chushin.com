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

  root to: 'static_pages#top'
  resources :samples
  #
  # draw :apis
  # draw :admins
end

# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        static_pages#top
#                   samples GET    /samples(.:format)                                                                       samples#index
#                           POST   /samples(.:format)                                                                       samples#create
#                new_sample GET    /samples/new(.:format)                                                                   samples#new
#               edit_sample GET    /samples/:id/edit(.:format)                                                              samples#edit
#                    sample GET    /samples/:id(.:format)                                                                   samples#show
#                           PATCH  /samples/:id(.:format)                                                                   samples#update
#                           PUT    /samples/:id(.:format)                                                                   samples#update
#                           DELETE /samples/:id(.:format)                                                                   samples#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
