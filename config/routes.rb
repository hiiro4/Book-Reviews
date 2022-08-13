Rails.application.routes.draw do
 root "public/books#index"

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
    resources :users,only:[:show, :index] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :reviews,only:[:show, :new, :index, :create]
    resource :favorites,only:[:create, :destroy]
    resources :bookshelves,only:[:destroy]
      post "bookshelves/will_read_create"
      post "bookshelves/read_create/:id", to: "bookshelves#read_create",as:"be_read"
  end
end
