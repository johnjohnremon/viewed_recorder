Rails.application.routes.draw do
  get 'posts/index'
  post "posts/index" => "posts#index"
  get 'posts/new'
  get 'posts/:id' => "posts#show"
  get 'posts/:id/delete' => "posts#delete"
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/editsave' => 'posts#editsave'
  post "posts/create" => "posts#create"

  get '/' => "home#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
