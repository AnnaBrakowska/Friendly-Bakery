require 'sinatra'
require "sinatra/reloader"
require "./class.rb"
require "httparty"
require "edamam-ruby"

cookie1 = Cookie.new("Chocolate Chip", "$3", "chocolate.jpg");
cookie2 = Cookie.new("Smores", "$4", "smores1.jpg")
cookie3 = Cookie.new("Vanilla Cloud", "$3.80", "vanilla1.jpg")
cookie4 = Cookie.new("Peanutbutter", "$3.5", "pean.jpg")
cookie5 = Cookie.new("Lorem ipsum", "$2", "chocolate.jpg")
cookie6 = Cookie.new("Lorem ipsum", "$5", "vanilla1.jpg")


cake1 = Cake.new("Double Chocolate", "$122", "triple.jpg")
cake2 = Cake.new("Triple Chocolate", "$114", "chocolate1.jpg")
cake3 = Cake.new("Triple Vanilla", "$139", "berry.jpg")
cake4 = Cake.new("Lava Chocolate", "$128", "blueberry.jpg")
cake5 = Cake.new("Butter Cake", "$125", "butter.jpg")
cake6 = Cake.new("Awesome Chocolate", "$120", "white.jpg")


muffin1 = Cake.new("Vegan Muffin", "$1.2", "ugly1.jpg")
muffin2 = Cake.new("Triple Chocolate", "$2.5", "vegan2.jpg")
muffin3 = Cake.new("Triple Chocolate", "$120", "carrot.jpg")
muffin4 = Cake.new("Oatmeal Muffin", "$2", "oats.jpg")
muffin5 = Cake.new("Banana Muffin", "$3.4", "banana.jpg")
muffin6 = Cake.new("Persimmon Muffin", "$3", "persimmon.jpg")





get '/' do
    @output = "Welcome to our bakery"
    erb :welcome
end


get '/cookies' do
    @header = "OUR COOKIES"
    @cookies = [cookie1, cookie2, cookie3, cookie4, cookie5, cookie6]
    @output = @cookies
    erb :display, :layout => :layoutShop
    
 end


 get '/cakes' do
    @header = "OUR CAKES"
    @cakes = [cake1, cake2, cake3, cake4, cake5, cake6]
    @output=@cakes
    erb :display, :layout => :layoutShop
 end


 get '/muffins' do
    @header = "OUR MUFFINS"
    @muffins = [muffin1, muffin2, muffin3, muffin4, muffin5, muffin6]
    @output=@muffins
    erb :display, :layout => :layoutShop
 end


 get '/about'  do
 erb :about
 end



 get '/recipes'  do
    erb :recipes, :layout => :layoutShop
 end

   

# get "/displayRecipes" do
#     erb :displayRecipes
# end



post "/displayRecipes" do

    @@input = params[:input]

    if @@input.nil? || @@input.empty? 
        redirect "/recipes"
    end
     
    @@response = HTTParty.get("https://api.edamam.com/search?q=" + @@input + "&app_id=#{ENV["APP_ID"]}&app_key=#{ENV["APP_KEY"]}");


    @@data = @@response["hits"]
    @@output = @@response["hits"][0]["recipe"]["label"]
    p @@output


    erb :displayRecipes, :layout => :layoutShop
end