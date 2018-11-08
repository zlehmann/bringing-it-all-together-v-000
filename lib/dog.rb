class Dog
  attr_accessor :id, :name, :breed

  def initialize(input)
    @id = nil
    @name = input['name:']
    @breed = input['breed:']
  end

  def attributes
  end

end
