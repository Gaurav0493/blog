Rails.application.routes.draw do

  get 'welcome/index'
    resources :articles do
     resources :sentence
    end
  root 'welcome#index'
  get '/articles/:article_id/sentence/:id/sentiment', to: 'sentence#sentiment', as: :sentence_sentiment
  get '/articles/:article_id/sentence/:id/token', to: 'sentence#token', as: :sentence_token
  get '/articles/:article_id/sentence/:id/category', to: 'sentence#category', as: :sentence_category
  get '/articles/:article_id/sentence/:id/entity', to: 'sentence#entity', as: :sentence_entity
end
