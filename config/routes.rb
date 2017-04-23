require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do

  resources :categories
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web, at: "/sidekiq"

  #devise_for :users
  # devise_for :users
  resources :tagoverlaps
  resources :tagexcepts
  resources :feeds do
    resources :infos
  end
  resources  :categories
  resources  :pages
  resources  :sourcehtmls

  scope module: :feeds do
    resources :pages, only: [:index, :show]
  end

  root 'pages#index'
  get 'loadnews', to: 'pages#load'
  get 'loadnews1', to: 'pages#load1'
  get 'analyze', to: 'pages#analyze'
  get 'addwindow', to: 'pages#addwindow'
 # get 'category/:category', to: 'pages#index', as: :category
  get 'ss', to: 'pages#index'
  get 'data', to: 'pages#index', as: :data
  get 'atags', to: 'pages#atags', controller: 'tag'
  get 'tag_cloud', to: 'pages#tag_cloud'
  get 'tags/:tag', to: 'pages#index', as: :tag
  # get 'data/:data', to: 'pages#index', as: :data
  get 'info', to: 'infos#info'
  get 'remove_tags',  controller: 'tag', to: 'tag#rtags'
  get 'tagexport',  controller: 'tag', to: 'tag#tagexport'
  get 'tagimport', to:   'pages#tagimport', controller: 'tag'
  get 'search_tags', to: 'pages#search_tags'
  post 'search_tags', to: 'pages#index'
  get 'redis', to: 'pages#redis'
  get 'rss', to: 'pages#rss'
  get 'infoday', to: 'infos#infoday'
  get 'infoday1', to: 'infos#infoday1'
  get 'infotoday', to: 'infos#infotoday'
  get 'html', to: 'sourcehtmls#html'
  get 'tmp', to: 'pages#tmp'
  get 'tgram', to: 'pages#tgram'
  get 'proba', to: 'pages#proba'
  get 'diff', to: 'pages#diff'
  get 'parser', to: 'pages#parser'
  get 'sourceexport', to:   'sources#sourceexport'
  get 'sourceimport', to:   'feeds#sourceimport'
  get 'tagexceptexport',  controller: 'tag', to: 'tag#tagexceptexport'
  get 'tagexceptimport',  controller: 'tag', to: 'tag#tagexceptimport'
end
