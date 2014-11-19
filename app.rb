require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'sinatra/reloader' if development?

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
class Todo
  include DataMapper::Resource
  property :id, Serial
  property :no, Integer
  property :content, Text, :required => true
  property :done, Boolean, :required => true, :default => false
  property :flag, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do 
  @todos = Todo.all :order => :id.asc
  if !@todos.empty?
    index = 1
    @todos.each do |item|
      item.no = index
      index +=1
    end
  end
  @todos.save
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
  todos = Todo.all
  if !todos.empty?
    index = 1
    todos.each do |item|
      item.no = index
      index +=1
    end
  end
  todos.save
  redirect to '/addNew'
end

# This is the ajax route for adding a new todo item
get '/addNew' do
  @ob=Todo.last
  erb :add, :layout => false
  
end

get '/:id' do
  @n = Todo.get params[:id]
  @title = "Edit todo ##{@n.no}"
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

post '/:id/flag' do
  @n = Todo.get(params[:id])
  @n.flag = !@n.flag
  @n.updated_at =Time.now
  @n.save
  erb :flag, :layout => false  
end

get '/:id/delete' do
  @todo = Todo.get params[:id]
  @title = "Confirm deletion of todo ##{@todo.no}"
  erb :delete
end

delete '/:id' do 
  n = Todo.get params[:id]
  n.destroy
  redirect '/'
end