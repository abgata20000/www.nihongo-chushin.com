# frozen_string_literal: true
namespace :api do
  resource :chats, only: %w(show create)
  resource :room, only: %w(show)
  namespace :rooms do
    resources :users, only: %w(index)
  end
  resource :my_pages, only: %w(show)
end
