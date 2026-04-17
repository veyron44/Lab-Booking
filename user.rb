class User
  attr_reader :id, :name, :role

  def initialize(id:, name:, role:)
    @id = id
    @name = name
    @role = role
  end
end