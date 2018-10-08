# frozen_string_literal: true
namespace :api do
  resources :chats, only: %w(index create)
  resource :room, only: %w(show)
  namespace :rooms do
    resources :users, only: %w(index)
  end
  resource :my_page, only: %w(show)
end
