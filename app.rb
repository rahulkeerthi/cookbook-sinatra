require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__, __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/' do
  @title = params['title']
  @description = params['description']
  @prep_time = params['prep_time']
  @difficulty = params['difficulty']
  recipe = Recipe.new(@title, @description, @prep_time, @difficulty)
  cookbook.add_recipe(recipe)
  @recipes = cookbook.all
  redirect to('/')
end

get '/:index' do
  delete_index = params['index'].to_i
  cookbook.remove_recipe(delete_index)
  redirect to('/')
end
