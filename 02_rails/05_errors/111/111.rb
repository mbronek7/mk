Rails.application.routes.draw do
  # ... pozostały ruting ...
  match '*unmatched', to: 'application#route_not_found', via: :all
end

