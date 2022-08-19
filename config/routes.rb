Rails.application.routes.draw do
 root "public/users#top"

devise_for :user,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
  end

  namespace :public do
    get 'homes/about'
    resources :books,only:[:index, :show]
    devise_scope :user do
    post 'users/guest_sign_in', to: '/public/sessions#guest_sign_in'
    end
    get "users/follow/:id", to: "users#follow",       as:"follow"
    get "users/follower/:id", to: "users#follower",   as:"follower"
    resources :users,only:[:show, :top, :destroy, :index] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings',  as: 'followings'
      get 'followers' => 'relationships#followers',    as: 'followers'
    end
    resources :reviews,only:[:show, :new, :index, :create, :destroy]
    resource :favorites,only:[:create, :destroy]
    resources :bookshelves,only:[:destroy]
      post "bookshelves/will_read_create"
      post "bookshelves/read_create/:id", to: "bookshelves#read_create",as:"read"
  end
end
