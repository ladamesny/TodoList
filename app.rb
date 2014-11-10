require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'sinatra/reloader' if development?

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
class Todo
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :done, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do 
  @todos = Todo.all :order => :id.desc
  @title = "All Notes"
  redirect '/new' if @todos.empty?
  erb :index
end

get '/new' do
  @title = "New"
  erb :new
end

post '/' do
  ob=Todo.new
  ob.content = params[:content]
  ob.created_at =Time.now
  ob.updated_at =Time.now
  ob.save
  redirect '/'
end

get '/:id' do
  @todo = Todo.get params[:id]
  @title = "Edit todo ##{params[:id]}"
  erb :edit
end

put '/:id' do 
  n = Todo.get params[:id]
  n.content = params[:content]
  n.done=params[:done] ? 1: 0
  n.updated_at =Time.now
  n.save
  redirect '/'
end

get '/:id/delete' do
  @todo = Todo.get params[:id]
  @title = "Confirm deletion of todo ##{params[:id]}"
  erb :delete
end

delete '/:id' do 
  n = Todo.get params[:id]
  n.destroy
  redirect '/'
end