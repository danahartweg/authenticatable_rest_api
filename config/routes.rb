RestApi::Application.routes.draw do

  devise_for :users, :controllers => { :sessions => "sessions",
  																		 :omniauth_callbacks => "users/omniauth_callbacks" }

	# root to: "home#index"

	get '/auth/:provider/callback', to: 'devise/sessions#create'
	# resources :sessions, :only => [:index, :create]

  scope '/v1' do
    resources :swatches, :collections, :manufacturers, :domains
  end
end
