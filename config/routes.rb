Studium::Application.routes.draw do
  get "users/index"

  get "/awaiting_confirmation",to: "users#dashboard",as: :confirm_user
  get "/dashboard",to: "users#dashboard",as: :user_root

  get "/users/:user_id/profile", to: "profiles#show", as: "user_profile"
  get "/users/:user_id/profile/edit", to: "profiles#edit",as: "edit_user_profile"
  put "/users/:user_id/profile",to: "profiles#update"

  get "/admin",to: "homepage#admin",as: "admin_index"
  get "/admin/materials",to: "homepage#materials",as: "admin_materials"
  get "/admin/materials/questions/add_question",to: "questions#category_selection",as: "add_new_materials_question" 

  get "/question_types/question_types_for_category_type/:category_name",to: "question_types#question_types_for_category_type"

  get ":controller/:action.:format"

  namespace :admin do
    namespace :materials do
      resources :questions
      resources :paragraphs
    end
  end

  devise_for :users,controllers: {registrations: "registrations"}

  root to: "homepage#index",as: :index
end
