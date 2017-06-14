class Car
  attr_accessor :vin, :manufacture, :id
  URL = "http://localhost:3001/api/v2"
  HEADER =  {"Accept" => "application/json",
                      "Authorization" => "Token token=coolbeans",
                      "X-User-Email" => "jordan@hiatt.com"
                    }

  def initialize(hash)
    @id = hash["id"]
    @vin = hash["vin"]
    @manufacture = hash["manufacture"]
  end

  def self.all
    array_cars = []
    Unirest.get("#{URL}/cars", headers: HEADER).body.each do |hash|
      array_cars <<  Car.new(hash)
    end
    array_cars
  end

  def self.find_by(input)
    hash = Unirest.get("#{URL}/cars/#{input[:id]}",
                          headers: HEADER, 
                        ).body
    car = Car.new(hash)
  end

  def self.create(hash)
        car = Unirest.post("#{URL}/cars.json", 
                          headers: HEADER, 
                          parameters: {vin: hash[:vin],
                                        manufacture: hash[:manufacture]}
                        ).body
  end

  def destroy
        car = Unirest.delete("#{URL}/cars/#{id}",
                            headers: HEADER, 
                              ).body
  end

  def update(hash)
        hash_1 = Unirest.patch("#{URL}/cars/#{self.id}.json", 
                          headers: HEADER, 
                          parameters: {vin: hash[:vin],
                                        manufacture: hash[:manufacture]}
                        ).body
        car = Car.new(hash_1)
  end

end
