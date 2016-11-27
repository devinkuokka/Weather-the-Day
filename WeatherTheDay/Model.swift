import Foundation
import ForecastIO
import CoreLocation


class Model {
    static let apiKey = "06afa3d18acac1c10822fec658f162ea"
    
    let geocoder = CLGeocoder()
    
    func getForecast(latitude: Float, longitude: Float, callback: @escaping (Void) -> Void) {
        let forecastIOClient = APIClient(apiKey: Model.apiKey)
        forecastIOClient.getForecast(latitude: Double(latitude), longitude: Double(longitude)) {
            (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                self.populate(forecast: currentForecast)
                callback()
            }
        }
    }
    
    
    func populate(forecast: Forecast) {
        preconditionFailure("This method must be overridden")
    }
    
    
    fileprivate static func loadLocationManager() -> CLLocationManager {
        let locationManager = CLLocationManager()
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        return locationManager
    }

}

