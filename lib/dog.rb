class Dog
  attr_accessor :id, :name, :breed

  def initialize(input)
    @id = nil
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

end
