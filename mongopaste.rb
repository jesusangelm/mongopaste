require "rubygems"
require "sinatra"
require "json"
require "rack-flash"
require "sinatra/redirect_with_flash"
require "coderay"
require "./model/snippet"
Bundler.require

enable :sessions
use Rack::Flash

SITE_TITLE = "MongoSnippets - Venezuela"
SITE_DESCRIPTION = "Fragmentos de codigo para compartir"

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

#Index Action
get "/" do
  @snippets = Snippet.all
  @title = "Snippets"

  erb :index
end

#get "/favicon.ico" do
#  redirect "/"
#end

#Create Action
post "/" do
  s = Snippet.new
  s.title = params[:title]
  s.language = params[:language]
  s.code = params[:code]

  if s.save
    redirect "/", :notice => "Snippet guardado!"
  else
    redirect "/", :error => "Error al guardar el Snippet..."
  end

end

#Show Action
get "/:id" do
  @snippet = Snippet.find params[:id]

  if @snippet
    @title = @snippet.title
    erb :show
  else
    redirect "/", :error => "No se encontro el Snippet..."
  end
end

get "/:id/delete" do
  @snippet = Snippet.find params[:id]
  @title = "Eliminando Snippet."

  if @snippet
    erb :delete
  else
    redirect "/", :error => "No se encontro el Snippet..."
  end
end

# Delete Action
delete "/:id" do
  s = Snippet.find params[:id]
  
  if s.destroy
    redirect "/", :notice => "Snippet Eliminado!"
  else
    redirect "/", :error => "Error al eliminar el Snippet..."
  end
end
