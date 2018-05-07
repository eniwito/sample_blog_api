Rails.application.routes.draw do
  resources :posts, only: :create do
    post :vote, on: :member
    get :top, on: :collection
    get :ip_list, on: :collection
  end
end
