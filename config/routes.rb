Rails.application.routes.draw do
  get 'snippets/index'
  get 'snippets/new'

  post 'code/submit'

  post 'home/comment'
  get 'home/index'
  get "home/snippet/:id" => "home#snippet", :as => :view_single
  get "home/my_snippets"

  devise_for :users
  get 'snippets/api'

  root 'snippets#index'

end
