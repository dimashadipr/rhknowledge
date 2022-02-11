# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: redirect("/#{I18n.locale}", status: 302)

  authenticate :user do
    require 'sidekiq/web'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

    mount Sidekiq::Web => '/sidejob'
  end

  scope '/:locale', locale: /(#{I18n.available_locales.join('|')})/ do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get '/set-locales/:locale', to: 'locales#set_locale', as: :set_locale
    get '/', to: 'homes#index'

    resources 'articles', only: %i[index show] do
      member do
        get 'landing', to: 'articles#landing', as: :landing
      end
      collection do
        get 'detail/:slug', to: 'articles#show_page', as: :detail
      end
    end

    resources 'subscriptions', only: [:create]

    resources 'events', only: [:index] do
      collection do
        get 'event-calendar', to: 'events#event_calendar'
      end
    end
    resources 'contacts', only: %i[index create]
    resources 'abouts', only: [:index]
    resources 'networks', only: [:index]
    resources 'conferences', only: %i[index create] do
      collection do
        get 'download-tor', action: 'download_tor'
        get 'download-guide', action: 'download_guide'
        get 'download-faq', action: 'download_faq'
        get 'download-materi', action: 'download_materi'
        get 'download-schedule', action: 'download_schedule'

        get 'participant/:slug', to: 'participants#show', as: 'participant-menu'
        post 'participant/:slug/upload-paper', to: 'participants#upload_paper', as: 'upload-paper'
        post 'participant/:slug/upload-payment', to: 'participants#upload_payment', as: 'upload-payment'
        post 'participant/:slug/upload-presentation', to: 'participants#upload_presentation', as: 'upload-presentation'
      end
    end

    get 'training', to: 'trainings#index'
    get 'training2', to: 'training2s#index'
    get 'unfpa', to: 'unfpas#index'
    get 'unfpa2', to: 'unfpa2s#index'
    get 'unfpa3', to: 'unfpa3s#index'
    get 'webseriesunfpa', to: 'webseriesunfpas#index'
    get 'midwifestraining', to: 'midwifestrainings#index'
    get 'icifpra', to: 'icifpras#index'
    get 'resources', to: 'resources#index'
    get 'news', to: 'newss#index'
    get 'fgd', to: 'fgds#index'
  end

  namespace :admin do
    get '/set-locales/:locale_cms', to: 'locales#set_locale', as: :set_locale
    get '/', to: 'home#index'
    resources 'homepages', only: %i[index update]

    # resources 'sources'
    # resources 'banners'
    resources 'networks'
    resources 'resources' do
      collection do
        get  'counter', action: 'counter'
        post 'image_articles', to: 'image_articles#create'
      end

      member do
        post 'image_articles', to: 'image_articles#create'
      end
    end

    resources 'page_files', path: 'page-files', only: [:destroy]

    resources 'navigations' do
      collection do
        get 'tree-data', to: 'navigations#tree_data'
      end
    end
    resources 'events'
    resources 'recurring_events', only: %i[create edit update destroy]
    resources 'subscriptions' do
      member do
        get 'change-status', to: 'subscriptions#change_status'
      end
    end

    resources 'visitors', only: %i[index show] do
      collection do
        get 'detail/:visitor_token', to: 'visitors#detail_visitor_token', as: 'detail-visitor'
      end
    end

    resources 'inquiries'

    resources 'mailers' do
      collection do
        post 'image_articles', to: 'image_articles#create'
      end

      member do
        post 'image_articles', to: 'image_articles#create'
      end
    end

    resources 'participants' do
      collection do
        get 'select_options', action: 'select_options'
      end
      member do
        get 'assign-reviewer', to: 'participants#modal_assign_reviewer'
        post 'assign-reviewer', to: 'participants#assign_reviewer'

        get 'reviewer_paper', to: 'participants#modal_reviewer_paper'
        post 'reviewer_paper', to: 'participants#reviewer_paper'

        get 'final-review', action: 'modal_final_review'
        post 'final-review', action: 'final_review'

        get 'upload-abstract', action: 'modal_upload_abstract'
        post 'upload-abstract', action: 'upload_abstract'
      end
    end

    resources 'conferences' do
      collection do
        get 'participant_report', to: 'conference_reports#participant'
        get 'reviewer_report', to: 'conference_reports#reviewer'
      end
      member do
        get 'quick-links', to: 'conference_quick_links#index'
        post 'quick-links', to: 'conference_quick_links#create'

        get 'categories', to: 'conference_categories#index'
        post 'categories', to: 'conference_categories#create'

        get 'topic', to: 'conference_topics#index'
        post 'topic', to: 'conference_topics#create'

        get 'manage-speakers', to: 'conferences#get_speakers'
        post 'manage-speakers', to: 'conferences#manage_speakers'
      end
    end

    resources 'conference_participants' do
      collection do
        get 'select_options', action: 'select_options'
      end
    end

    resources 'conference_topics' do
      collection do
        get 'select_options', action: 'select_options'
      end
    end

    resources 'reviews'
    resources 'payments'

    resources 'roles'
    resources 'permissions'

    resources 'users' do
      collection do
        get 'change-password', action: 'change_password'
        put 'change-password', action: 'update_password'
      end
    end
  end
end
