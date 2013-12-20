AnyMenu::Application.routes.draw do

  resources :hours_availables do
    resources :exception_to_availabilities#, :only => [:new, :edit, :create, :update, :destroy]
  end
  #resources :exception_to_availabilities, :only => [:destroy]

  devise_for :users
  resources :topping_lists

  resources :toppings


  resources :items

  resources :sections

  resources :menus do
    resources :sections, :only => [:new, :create, :edit, :update] do
      member do
        get 'add'
      end
      resources :items
    end
  end

  resources :sectionalizations, :only => [:destroy]



  resources :stores

  root 'stores#index'

end
