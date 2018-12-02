# frozen_string_literal: true
namespace :api do
  resources :chats, only: %w(index create)
  resource :room, only: %w(show)
  namespace :rooms do
    resources :users, only: %w(index)
  end
  resource :my_page, only: %w(show)
end

namespace :api do
  namespace :v1 do
    resource :sessions, only: %w[create destroy show]
    resources :rooms, only: %w[index create update]
  end
end
