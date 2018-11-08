require 'pry'
class Dog
  attr_accessor :id, :name, :breed

  @@all = []

  def initialize(input)
    @id = input[:id]
    @name = input[:name]
    @breed = input[:breed]
    @@all << self
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

  def self.all
    @@all
  end

  def save(dog)
    sql = <<-SQL
      INSERT INTO dogs (name, grade)
      VALUES (?, ?)
    SQL

    if self.id == nil
      DB[:conn].execute(sql, dog.name, dog.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    else
      update
    end
    dog
  end

  def self.create(hash)
    new_dog = Dog.new(hash)
    Dog.save(new_dog)
    new_dog
  end

  def update
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ?
    SQL
    row = DB[:conn].execute(sql, name)
    result = nil
    Dog.all.each do |dog|
      if dog.id == row[0][0]
        result = dog
      end
    end
    result
  end
end
