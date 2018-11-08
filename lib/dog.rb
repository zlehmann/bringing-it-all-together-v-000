require 'pry'
class Dog
  attr_accessor :id, :name, :breed

  def initialize(input)
    @id = input[:id]
    @name = input[:name]
    @breed = input[:breed]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE dogs(
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE dogs;")
  end

  def self.new_from_db(array)
    hash = {:id => array[0], :name => array[1], :breed => array[2]}
    new_dog = Dog.new(hash)
  end

end
