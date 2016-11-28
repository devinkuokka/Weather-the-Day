import Foundation
import ForecastIO
import CoreLocation

class HomeModel : Model {
    
    let latitude : Float
    let longitude: Float
    
    var coordinates : CLLocationCoordinate2D {
        get {
            let lat = CLLocationDegrees(exactly: self.latitude)!
            let long = CLLocationDegrees(exactly: self.longitude)!
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
    }
    
    
    let iconPath : String
    let description : String
    let changeFromYesterday : String
    
    let currentTemp : Int
    let lowTemp : Int
    let highTemp : Int
    
    let chanceOfPrecip : Float
    let minutesUntilPrecip: Int
    let typeOfPrecip : Precipitation?
    

    
    required init(forecast: Forecast) {
        let data = forecast.currently!
        let today = forecast.daily!.data![0]
        
        self.latitude = forecast.latitude
        self.longitude = forecast.longitude
        
        self.iconPath = data.icon!.rawValue
        self.description = HomeModel.createDescription()
        self.changeFromYesterday = HomeModel.createChangeFromYesterday()
        
        self.currentTemp = Int(data.temperature!)
        self.lowTemp = Int(today.temperatureMin!)
        self.highTemp = Int(today.temperatureMax!)
        
        
        self.chanceOfPrecip = data.precipProbability!
        self.typeOfPrecip = data.precipType
        self.minutesUntilPrecip = HomeModel.findTimeUntilPrecip()
    }
    
    
    init (latitude: Float, longitude: Float, description: String,
          iconPath: String, temp: Int,
          low: Int, high: Int, chanceOfPrecip: Float, minutesUntilPrecip: Int,
          typeOfPrecip: Precipitation?) {
        self.latitude = latitude
        self.longitude = longitude
        self.changeFromYesterday = HomeModel.createChangeFromYesterday()
        self.iconPath = iconPath
        self.currentTemp = temp
        self.lowTemp = low
        self.highTemp = high
        self.chanceOfPrecip = chanceOfPrecip
        self.minutesUntilPrecip = minutesUntilPrecip
        self.typeOfPrecip = typeOfPrecip
        self.description = description
        
    }
    
    static func findTimeUntilPrecip() -> Int {
        return 0
    }
    
    static func createDescription() -> String {
        return ""
    }
    
    static func createChangeFromYesterday() -> String {
        return ""
    }
}
