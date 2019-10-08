class CarsService
    def self.makes
        cars_api_uri = Rails.application.secrets.cars_api_uri
        response     = HTTParty.get("#{cars_api_uri}/vehicles/GetAllMakes?format=json")
        response.dig('Results').map {|car| car['Make_Name']}.sort
    end

    def self.models make
        make         = make.include?(' ') ? make.split(' ').join('%20') : make
        cars_api_uri = Rails.application.secrets.cars_api_uri
        response     = HTTParty.get("#{cars_api_uri}/vehicles/GetModelsForMake/#{make}?format=json")
        response.dig('Results').map {|make| make['Model_Name']}
    end
end