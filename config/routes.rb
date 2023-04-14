Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  "/urls",                to: 'urls#index',           as: :index
  get  "/urls/analytics",      to: 'urls#analytics',       as: :analytics
end
