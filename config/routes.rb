AnyMenu::Application.routes.draw do
  devise_for :users
  resources :topping_lists

  resources :toppings


  resources :items

  resources :sections #, :only => [:show]

  resources :menus do
    resources :sections, :only => [:new, :create, :edit, :update]
  end

  resources :sectionalizations, :only => [:destroy]



  resources :stores

  root 'stores#index'

end
