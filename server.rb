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

  @titles = []

  @movies.each do |movie|
    @titles << movie[:title]
    @id << movie[:id]
  end

end

get '/movies' do
  init
  erb :movie_list
end

get 'movies/:movie_id' do
  init
  erb :movie_id
end
