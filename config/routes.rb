Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user, ->(u) { u.type == 'Parent' } do
      root 'pages#parent_dashboard', as: :parent_root
      resources :grades, only: [:index, :show]
    end

    authenticated :user, ->(u) { u.type == 'Teacher' } do
      root 'pages#teacher_dashboard', as: :teacher_root
      resources :students, only: [:show]
      resources :sections, only: [:index, :show] do
        member do
          get :students
          get :add_grade, to: 'sections#add_grade'
          get :show_grades, to: 'sections#show_grades'
          post :create_grades, to: 'sections#create_grades'
        end
      end
    end
    authenticated :user do
      resources :chatrooms, only: [:index, :show] do
        resources :messages, only: :create
      end
    end
  end
  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

# authenticated :user, ->(u) { u.super_admin? } do
#   root 'companies#index', as: :admin_root
# end
# authenticated :user, ->(u) { !u.super_admin? && u.company.cgu_accepted_at.nil? } do
#   root 'pages#help', as: :starting_root
# end
