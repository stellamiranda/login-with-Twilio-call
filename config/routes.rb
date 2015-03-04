Rails.application.routes.draw do
	
	get "log_out" => "sessions#destroy", :as => "log_out"
	get "log_in" => "sessions#new", :as => "log_in"
	get "new_auth" => "sessions#new_auth", :as => "new_auth"
	get "boom" => "sessions#boom", :as => "boom"
	get "sign_up" => "users#new", :as => "sign_up"

	root :to => "sessions#new"
	resources :users do
		post 'voice', :on => :member
		post 'text_response', :on => :member
	end
	resources :sessions do
		 post 'create_session', :on => :collection

	end
end