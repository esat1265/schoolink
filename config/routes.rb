Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user, ->(u) { u.type == 'Parent' } do
      root 'pages#parent_dashboard', as: :parent_root
    end

    authenticated :user, ->(u) { u.type == 'Teacher' } do
      root 'pages#teacher_dashboard', as: :teacher_root
      resources :sections, only: [:index, :show] do
        member do
          get :students
          get :add_grade, to: 'sections#add_grade'
          post :create_grades, to: 'sections#create_grades'
        end
      end
    end
  end
  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
  resources :grades, only: [:index]
end

# authenticated :user, ->(u) { u.super_admin? } do
#   root 'companies#index', as: :admin_root
# end
# authenticated :user, ->(u) { !u.super_admin? && u.company.cgu_accepted_at.nil? } do
#   root 'pages#help', as: :starting_root
# end
