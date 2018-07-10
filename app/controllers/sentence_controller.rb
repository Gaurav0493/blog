require "google/cloud/language"

class SentenceController < ApplicationController

  def sentiment
   # text_content= "Google, headquartered in Mountain View, unveiled the new Android phone at the Consumer Electronic Show"
    @article = Article.find(params[:id])
    text_content = @article.text
    language = Google::Cloud::Language.new
    response = language.analyze_sentiment content: text_content, type: :PLAIN_TEXT
    sentiment = response.document_sentiment
    @Overall_score = sentiment.score
    sentences = response.sentences
    a = {}
    sentences.each do |sentence|
      sentiment = sentence.sentiment
      a[sentence.text.content] = sentiment.score
    end
    @sentiment=a
  end

  def entity
    @article = Article.find(params[:id])
    text_content = @article.text
  #  text_content= "Google, headquartered in Mountain View, unveiled the new Android phone at the Consumer Electronic Show"
    language = Google::Cloud::Language.new
    response = language.analyze_entities content: text_content, type: :PLAIN_TEXT
    entities = response.entities
    a = {}
    entities.each do |entity|
      puts "Entity =#{entity.name} #{entity.type}"
      if entity.metadata["wikipedia_url"]
        puts "URL: #{entity.metadata['wikipedia_url']}"
      end
      a[entity.name]=entity.type,entity.metadata['wikipedia_url']
    end
    @entity=a
  end

  def token
    @article = Article.find(params[:id])
    text_content = @article.text
  #  text_content= "Google, headquartered in Mountain View, unveiled the new Android phone at the Consumer Electronic Show"
    language = Google::Cloud::Language.new
    response = language.analyze_syntax content: text_content, type: :PLAIN_TEXT
    sentences = response.sentences
    tokens    = response.tokens
    puts "Sentences: #{sentences.count}"
        puts "Tokens: #{tokens.count}"
    @AllTokens=tokens.count
    a={}
    tokens.each do |token|
        puts "#{token.part_of_speech.tag} #{token.text.content}"
        a[token.part_of_speech.tag]= token.text.content
    end
    @token=a
  end

  def category
    @article = Article.find(params[:id])
    text_content = @article.text
    #text_content= "Google, headquartered in Mountain View, unveiled the new Android phone at the Consumer Electronic Show. Sundar Pichai said in his keynote that users love their new Android phones."
    language = Google::Cloud::Language.new
    response = language.classify_text content: text_content, type: :PLAIN_TEXT
    categories = response.categories
    a={}
    categories.each do |category|
       a[category.name]= category.confidence
    end
    @category=a
  end
end
