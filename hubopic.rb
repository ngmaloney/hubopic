require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/respond_with'
require 'json'
require_relative 'lib/album'

before do
  @config = OpenStruct.new({host: host(request)})
end

respond_to :html, :json

get "/" do
  @albums = Album.list
   respond_to do |format|
     format.json { {albums: @albums}.to_json }
     format.html { @albums }
   end
end

get "/:album" do
  @album = Album.new(params[:album], @config)
  respond_to do |format|
    format.json { {photo: @album.random}.to_json }
    format.html { @album.random }
  end
end

get "/:album/bomb/:count" do
  @album = Album.new(params[:album], @config)
  @photos = @album.random(params[:count].to_i)
  respond_to do |format|
    format.json { {photos: @photos}.to_json }
    format.html { @photos.join(",") }
  end
end

helpers do
  def host(request)
    "#{request.scheme}://#{request.env['HTTP_HOST']}"
  end
end
