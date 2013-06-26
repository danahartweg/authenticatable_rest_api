RestApi::Application.routes.draw do
  scope '/v1' do
    resources :users
  end
end
