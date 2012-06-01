Studium::Application.routes.draw do
  get "users/index"

  get "/awaiting_confirmation",to: "users#dashboard",as: "confirm_user"
  get "/dashboard",to: "users#dashboard",as: :user_root

  devise_for :users,controllers: {registrations: "registrations"}

  root to: "homepage#index",as: "index"  
end
