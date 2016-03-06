require ("pg")
require("pry-byebug")

class Bookmark

  attr_reader :url,  :title, :category, :id

  def initialize(params)
    @id = nil || params["id"]  #nil when creating  has doesn have id @ that point 
    @url= params["url"]
    @title= params["title"].downcase
    @category=params["category"].downcase
  end

  def url_path
    return @url
  end

  def save()
    sql = "INSERT INTO bookmarks (
      url,
      title,
      category) VALUES (
      '#{@url}',
      '#{@title}',
      '#{@category}')"

  Bookmark.run_sql(sql)
  end
  
  def self.all   
    bookmarks =   Bookmark.run_sql("SELECT * FROM bookmarks")
    result = bookmarks.map{|bookmark| Bookmark.new(bookmark)}
    return result
  end

  def self.find(id)
    bookmark = Bookmark.run_sql("SELECT * FROM bookmarks WHERE ID=#{id}")
    result = Bookmark.new( bookmark.first )  #or pizza[0] or pizza.pop or pizza.last
    return result
  end

  # def self.find_titles(title)
  #   bookmarks = Bookmark.run_sql("SELECT * FROM bookmarks WHERE title='#{title.downcase}'")
  #   result = bookmarks.map{|bookmark| Bookmark.new(bookmark)}
  #   return result
  # end

  # def self.find_category(category)
  #   bookmarks = Bookmark.run_sql("SELECT * FROM bookmarks WHERE category='#{category.downcase}'")
  #   result = bookmarks.map{bookmark| Bookmark.new(bookmark)}
  #   return result
  # end
  def self.find_multi(search)
    bookmarks= Bookmark.run_sql("SELECT * FROM bookmarks WHERE LOWER(title) LIKE '#{search.downcase}' OR LOWER(category) LIKE '#{search.downcase}'")
    result = bookmarks.map{|bookmark| Bookmark.new(bookmark)}
    return result
  end

   def self.update(params)
     sql = "UPDATE bookmarks SET url='#{params['url']}',title='#{params['title']}',category='#{params['category']}' WHERE ID='#{params['id']}'"
     Bookmark.run_sql(sql)
   end

   def self.destroy( id ) 
    Bookmark.run_sql("DELETE FROM bookmarks WHERE id=#{id}")
   end

   private

   def self.run_sql(sql)
      begin
        db = PG.connect({dbname: "bookmark_data", host: "localhost"})
        result = db.exec(sql)
        return result
      ensure
        db.close
      end
   end

end

