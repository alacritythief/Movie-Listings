require 'sinatra'
require 'csv'

RESULTS_PER_PAGE = 20

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

def pagination
  if @prev_page == 0
    @page = 2
  end

  @page = (params[:page] || 1).to_i
  start = RESULTS_PER_PAGE * (@page - 1)
  ending = RESULTS_PER_PAGE * (@page - 1) + (RESULTS_PER_PAGE - 1)
  @movies = @movies[start..ending]
  @next_page = @page + 1
  @prev_page = (@page - 1).abs
  if @prev_page == 0
    @prev_page = 1
  end
end

get '/' do
  redirect "/movies"
end

get '/movies?page=:page' do
  init
  pagination
  erb :movie_list
end

get '/movies' do
  init
  pagination
  erb :movie_list
end

get '/movies/:movie_id' do
  init
  erb :movie_id
end

