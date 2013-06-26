RestApi::Application.routes.draw do
  scope '/v1' do
    resources :users, :swatches, :collections, :manufacturers, :domains
  end
end
