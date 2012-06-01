Studium::Application.routes.draw do
  devise_for :users

  root to: "homepage#index",as: "index"  
end
