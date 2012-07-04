Studium::Application.routes.draw do
  get "users/index"

  get "/awaiting_confirmation",to: "users#dashboard",as: :confirm_user
  get "/dashboard",to: "users#dashboard",as: :user_root

  get "/users/:user_id/profile", to: "profiles#show", as: "user_profile"
  get "/users/:user_id/profile/edit", to: "profiles#edit",as: "edit_user_profile"
  put "/users/:user_id/profile",to: "profiles#update"

  get "/admin",to: "homepage#admin",as: "admin_index"
  get "/admin/materials",to: "admin/materials/base#index",as: "admin_materials"
  get "/admin/materials/questions/add_question",to: "admin/materials/questions#category_selection",as: "add_new_materials_question" 

  get "/admin/materials/questions/edit_paragraph",to: "admin/materials/questions#edit_paragraph",as: "admin_materials_question_edit_paragraph"

  get ":controller/:action.:format"

  get "/admin/materials/questions/cancel_edit_question",to: "admin/materials/questions#cancel_edit_question"
  get "/admin/materials/questions/remove_paragraph",to: "admin/materials/questions#remove_paragraph"
  get "/admin/materials/questions/remove_choice",to: "admin/materials/questions#remove_choice"

  namespace "admin" do
    namespace "materials" do
      root to: "base#index",as: "admin_materials_index"
      resources :questions
      resources :paragraphs
    end
  end

  resources :rooms
  get "/rooms/join/:room_id", to: "rooms#join", as:"room_join"
  #get "/choose/:room_id/:choice_id", to: "rooms#choose", as:"room_choose_choice"
  post "/rooms/choose", to: "rooms#choose", as: "room_choose_choice"
  post "/rooms/show_question", to: "rooms#show_question", as: "room_show_question"
  post "/rooms/show_explanation", to: "rooms#show_explanation", as: "room_show_explanation"

  devise_for :users,controllers: {registrations: "registrations"}

  root to: "homepage#index",as: :index
end
