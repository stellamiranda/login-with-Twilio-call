Rails.application.routes.draw do
	get "log_out" => "sessions#destroy", :as => "log_out"
	get "log_in" => "sessions#new", :as => "log_in"
	get "new_auth" => "sessions#new_auth", :as => "new_auth"
	get "boom" => "sessions#boom", :as => "boom"
	get "sign_up" => "users#new", :as => "sign_up"

	post 'twilio/voice' => 'twilio#voice'
	post 'twilio/sms' => 'twilio#sms'
	get 'twilio/text_response' => 'twilio#text_response'
	get 'twilio/voice2' => 'twilio#voice2'


	root :to => "sessions#new"
	resources :users
	resources :sessions 

	#Twilio

	
end
