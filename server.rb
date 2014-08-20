require 'sinatra'
require 'csv'
require 'pry'

def csv_import
  @movies = []

  CSV.foreach('public/movies.csv', headers: true, :header_converters => :symbol) do |row|
    @movies << row.to_hash
  end
end

def init
  csv_import

  choice = params[:movie_id]
  @titles = []
  @id = []

  @movies.each do |movie|
    @titles << movie[:title]
    @id << movie if movie[:id] == choice
  end

end

get '/' do
    redirect "/movies"
end

get '/movies' do
  init
  erb :movie_list
end

get '/movies/:movie_id' do
  init
  erb :movie_id
end

