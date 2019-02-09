require_relative('../db/sql_runner')

class City

  attr_accessor :name, :country_id
  attr_reader :id

    def initialize(options)
      @id = options['id'].to_i if options['id']
      @name = options['name']
      @country_id = options[country_id].to_i
    end

    def save()
      sql = "INSERT INTO cities (country_id, name)
      ValUES($1, $2)
      RETURNING id"
      values = [@country_id, @name]
      result = SqlRunner.run(sql, values)
      id = reult.first['id']
      @id = id
    end

    def country() #this is the method to bring country data for use here
      country = Country.find(@country_id)
      return country
    end

    def update() #†his method should also update the country data
      sql = "UPDATE cities
      SET
      (country_id,
        name)=
        ($1, $2)
        WHERE id = $3"
        values = [@country_id, @name, @id]
        SqlRunner.run(sql, values)
      end

      def delete() #this should delete also from country as delete is set up as a cascade
        sql = "DELETE from cities
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end

      def self.all()
        sql = "SELECT * FROM cities"
        city_data = SqlRunner.run(sql)
        cities = map_items(city_data)
        return cities
      end

      def self.map_items(city_data)
        return city_data.map {|city| City.new(city)}
      end

      def self.find(id)
        sql = "SELECT * FROM cities
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        city = City.new(result)
        return city
      end

end
