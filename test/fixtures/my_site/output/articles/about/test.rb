class Base
  
  def self.attribute(name, type=:string)
    puts "self: #{self.inspect}"
  end
  
end

class Mine < Base
  attribute :name, :string
end