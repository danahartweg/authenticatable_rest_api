RestApi::Application.routes.draw do

	# Routes all http option requests to set CORS preflight headers
	match '*path' => 'application#cors_preflight', :via => :options

	# User information requests are sent to the api scoped route
  resources :users, except: [:index, :show]

  # Routing api key creation and deletion
  post 'session' => 'session#create'
  delete 'session' => 'session#destroy'

	# Scope for api version one
  scope '/v1' do
    resources :swatches, :collections, :manufacturers, :domains, :users
  end
end
