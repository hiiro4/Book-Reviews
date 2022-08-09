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
    resources :reviews,only:[:show, :new, :index, :create]
    resources :bookshelves,only:[:destroy]
      post "bookshelves/will_read_create"
      post "bookshelves/will_read_show", as: "will_book"
      post "bookshelves/read_create"
      post "bookshelves/read_show", as: "read_book"
  end
end
