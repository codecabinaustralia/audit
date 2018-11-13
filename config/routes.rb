Rails.application.routes.draw do
  resources :audits do
  	resources :questions
  	get 'start_audit' => "audits#start_audit"
  	get 'start_audit_list' => "audits#start_audit_list"
    get 'edit_audit_list' => "audits#edit_audit_list"
  	post 'save_audit' => "audits#save_audit"
    get 'complete_audit' => "audits#complete_audit"
    get 'submitted_audits' => "audits#submitted_audits"
    get 'report_card' => "audits#report_card"
  end

  get 'my_audit_log' => 'audits#my_audit_log'

  devise_for :users
  get 'static/home'

  root to: "audits#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
