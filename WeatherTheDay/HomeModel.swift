import Foundation
import ForecastIO
import CoreLocation

class HomeModel : Model {
    let locationManager : CLLocationManager
    
    var latitude : Float!
    var longitude: Float!
    
    var iconPath : String!
    var description : String!
    var changeFromYesterday : String!
    
    var currentTemp : Int!
    var lowTemp : Int!
    var highTemp : Int!
    
    var chanceOfPrecip : Float!
    var minutesUntilPrecip: Int!
    var typeOfPrecip : Precipitation!
    
    init(callback: @escaping (Void) -> Void) {
        self.locationManager = CLLocationManager()
        let location = locationManager.location!.coordinate
        super.init()
        getForecast(latitude: Float(location.latitude), longitude: Float(location.longitude), callback: callback)
    }
    
    init(locationManager: CLLocationManager, forecast: Forecast) {
        self.locationManager = locationManager
        super.init()
        populate(forecast: forecast)
    }
    
    
    override func populate(forecast: Forecast) {
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
        
        
        self.chanceOfPrecip = data.precipProbability
        self.typeOfPrecip = data.precipType
        self.minutesUntilPrecip = HomeModel.findTimeUntilPrecip()
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
