Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  "/urls",                to: 'urls#index',           as: :index
  post "/shorten",             to: 'urls#shorten',         as: :shorten
  get  "/:slug",               to: 'urls#show',            as: :show
  get  "/:id/report",          to: 'urls#single_report',   as: :report
  get  "/urls/analytics",      to: 'urls#analytics',       as: :analytics
end
