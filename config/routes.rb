Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'xing/authenticate' => 'xing#authenticate'
  get 'xing/authenticated_result' => 'xing#authenticated_result'

  get 'users/contacts'

end
