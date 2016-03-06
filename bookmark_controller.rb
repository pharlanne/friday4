require("sinatra")
require("sinatra/contrib/all") if development?
require_relative("./models/bookmark")


get "/" do
  erb(:home)
end

get "/bookmark/new" do
  erb(:new)
end

# get "/bookmark"do
#   if params['title'] != '' && params['title'] != nil
#     @bookmarks = Bookmark.find_titles(params['title'])
#   elsif params['category'] != '' && params['category'] != nil
#     @bookmarks = Bookmark.find_category(params['category'])
#   else
#     puts "finding all"
#     @bookmarks = Bookmark.all
#   end
#   erb(:index)
# end
get"/bookmark" do
  if params['search'] != '' && params['search'] != nil
    @bookmarks = Bookmark.find_multi(params['search'])
    if@bookmarks.length > 0
      erb(:index)
    else
      erb(:none_found)
    end
  else
    @bookmarks = Bookmark.all
    erb(:index)
  end
end


post"/bookmark" do 
  @bookmark=Bookmark.new(params)
  @bookmark.save
  erb(:create)
  redirect to("/bookmark")
end

get "/bookmark/:id" do
  @bookmark = Bookmark.find(params[:id])
  erb(:show)
 
end

get"/bookmark/:id/edit" do
  @bookmark = Bookmark.find(params[:id])
  erb(:edit)
end

post"/bookmark/:id" do
  puts "params"
  puts params
  @bookmark = Bookmark.update(params)
  redirect to("bookmark/#{params[:id]}")
end

post"/bookmark/:id/delete" do
  Bookmark.destroy(params[:id])
  redirect to("/bookmark")
end