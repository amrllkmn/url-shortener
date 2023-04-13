Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  "/urls",                to: 'urls#index'
  post "/urls/shorten",        to: 'urls#shorten'
  get  "/urls/:slug",          to: 'urls#show'
  get  "/urls/:id/report",     to: 'urls#single_report'
end
