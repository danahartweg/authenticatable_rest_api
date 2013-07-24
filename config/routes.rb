RestApi::Application.routes.draw do

  resources :users, except: [:index, :show]
  post 'session' => 'session#create'

  # match '*path' => 'application#cors_preflight', :via => :options

	# root to: "home#index"

	# get '/auth/:provider/callback', to: 'devise/sessions#create'
	# resources :sessions, :only => [:index, :create]

  scope '/v1' do
    resources :swatches, :collections, :manufacturers, :domains, :users
  end
end
