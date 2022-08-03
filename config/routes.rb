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
    resources :users,only:[:show, :index]
  end
end
