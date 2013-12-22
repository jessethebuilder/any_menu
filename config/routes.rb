AnyMenu::Application.routes.draw do

  resources :hours_availables do
    resources :exception_to_availabilities#, :only => [:new, :edit, :create, :update, :destroy]
  end
  #resources :exception_to_availabilities, :only => [:destroy]

  devise_for :users
  resources :topping_lists

  resources :toppings




  resources :sections do
    resources :items do
      member do
        get 'remove'
        get 'add'
        get 'move'
      end
    end
  end

  resources :menus do
    resources :sections, :only => [:new, :create, :edit, :update] do
      member do
        get 'remove'
        get 'add'
        get 'move'
      end
      resources :items do
        member do
          get 'remove'
          get 'add'
          get 'move'
        end
      end
    end
  end

  #resources :sectionalizations, :only => [:destroy]



  resources :stores

  root 'stores#index'

end
