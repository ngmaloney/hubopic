require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'json'
require_relative 'lib/album'

class Hubopic < Sinatra::Application
  register Sinatra::Contrib

  configure do
    set :views, File.dirname(__FILE__) + "/views"
    set :public_folder, File.dirname(__FILE__) + "/public"
  end

  helpers do
    def host(request)
      "#{request.scheme}://#{request.env['HTTP_HOST']}"
    end
  end

  before do
    @config = OpenStruct.new({host: host(request)})
  end

  respond_to :html, :json

  get "/" do
    @albums = Album.list
     respond_to do |format|
       # JSON requires http header of application-json
       format.json { {albums: @albums}.to_json }
       format.html { haml :index }
     end
  end

  get "/:album" do
    @album = Album.new(params[:album], @config)
    @photos = @album.images
    respond_to do |format|
      format.json { {photos: @photos}.to_json }
      format.html { haml :album_index }
    end
  end

  get "/:album/random" do
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

end

