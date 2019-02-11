require_relative('../db/sql_runner')

class Country

  attr_reader :id
  attr_accessor :name, :id

  def initialize(details)
  @id = details["id"].to_i if details["id"]
  @name = details["name"]
  end

  def save #save for adding items to the database
    sql = "INSERT INTO countries(name)
    VALUES($1)
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first()['id'].to_i
  end

  def self.find(id) #for finding a country this is required for city method
    sql= "SELECT * FROM countries
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    country = Country.new(result)
    return country
  end

  def self.all() #class method to return all countries useful for later updates
    sql = "SELECT * FROM countries"
    country_data = SqlRunner.run(sql)
    country = map_items(country_data)
    return country
  end

  def self.map_items(country_data) #this should allow map of items in above
    return country_data.map { |country| Country.new(country) }
  end

  


end
