Studium::Application.routes.draw do
  get "paragraphs/show"

  get "paragraphs/new"

  get "paragraphs/create"

  get "paragraphs/edit"

  get "paragraphs/update"

  get "paragraphs/destroy"

  get "users/index"

  get "/awaiting_confirmation",to: "users#dashboard",as: :confirm_user
  get "/dashboard",to: "users#dashboard",as: :user_root

  get "/users/:user_id/profile", to: "profiles#show", as: "user_profile"
  get "/users/:user_id/profile/edit", to: "profiles#edit",as: "edit_user_profile"
  put "/users/:user_id/profile",to: "profiles#update"

  get "/admin",to: "homepage#admin",as: "admin_index"

  namespace :admin do
    namespace :materials do
      resources :questions
      resources :paragraphs
    end
  end

  devise_for :users,controllers: {registrations: "registrations"}

  root to: "homepage#index",as: :index
end
