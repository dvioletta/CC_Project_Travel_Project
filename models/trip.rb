require_relative('../db/sql_runner')
require('pry')

class Trip

  attr_reader :id
  attr_accessor :visited, :country_id, :city_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @country_id = options['country_id'].to_i
    @city_id = options['city_id'].to_i
    @visited = options['visited']
  end

  def save()
    sql = "INSERT INTO trips
    (country_id,
      city_id,
      visited)
      VALUES
      ($1,$2,$3)
      RETURNING id"
      values = [@country_id, @city_id, @visited]
      result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

    def city()
      city = City.find(@city_id)
      return city
    end

    def country()
      country = Country.find(@country_id)
      return country
    end

    def update()
      sql = "UPDATE trips
      SET
      (country_id,
        city_id,
        visited)
        =
        ($1, $2, $3)
        WHERE id = $4"
        values = [@country_id, @city_id, @visited, @id]
        SqlRunner.run(sql, values)
      end

      def delete()
        sql = "DELETE FROM trips
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end

      def self.all()
        sql = "SELECT * FROM trips"
        trip_data = SqlRunner.run(sql)
        trips = map_items(trip_data)
        return trips
      end

      def self.map_items(trip_data)
        return trip_data.map {|trip| Trip.new(trip)}
      end

      def self.find(id)
        sql = "SELECT * FROM trips
        WHERE id = $1"
        values =[id]
        result = SqlRunner.run(sql, values).first
        trip = Trip.new(result)
        return trip
      end

      def country_find()
      sql = "SELECT * FROM country
      WHERE id = $1"
      values = [@country_id]
      country = SqlRunner.run(sql, values)
      result= Country.new(country.first)
      return result
    end


    def city_find()
    sql = "SELECT * FROM city
    WHERE id = $1"
    values = [@city_id]
    city = SqlRunner.run(sql, values)
    result= City.new(city.first)
    return result
  end

  def self.delete_all
    sql = "DELETE FROM trips"
    SqlRunner.run(sql)
    end







end
