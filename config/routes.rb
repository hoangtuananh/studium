Studium::Application.routes.draw do
  get "users/index"

  get "/awaiting_confirmation",to: "users#dashboard",as: :confirm_user
  get "/dashboard",to: "users#dashboard",as: :user_root

  get "/users/:user_id/profile", to: "profiles#show"

  devise_for :users,controllers: {registrations: "registrations"}

  root to: "homepage#index",as: :index
end
