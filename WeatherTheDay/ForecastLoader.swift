import Foundation
import CoreLocation
import ForecastIO

class ForecastLoader {
    static fileprivate let apiKey = "06afa3d18acac1c10822fec658f162ea"
    static fileprivate let geocoder = CLGeocoder()
    static fileprivate let locationManager = loadLocationManager()
    
    
    /// Gets the forecast for the user's current location.
    static func getForecast<T: Model>(modelType: T.Type, callback: @escaping (T) -> Void) {
        if let currentPosition = locationManager.location?.coordinate {
            getForecast(coordinates: currentPosition, modelType: modelType, callback: callback)
        }
    }
    
    /// Gets the forecast for the provided address.
    static func getForecast<T: Model>(address: String, modelType: T.Type, callback: @escaping (T) -> Void) {
        geocoder.geocodeAddressString(address) {places, error in
            if let positon = places?[0].location?.coordinate {
                getForecast(coordinates: positon, modelType: modelType, callback: callback)
            }
        }
    }
    
    /// Gets the forecast for the location specified by the given coordinates.
    /// Requires a type parameter to make the Swift type checker happy, because
    /// you can't otherwise tell the type checker which class to instantiate.
    fileprivate static func getForecast<T: Model>(coordinates : CLLocationCoordinate2D, modelType: T.Type, callback: @escaping (T) -> Void) {
        let forecastIOClient = APIClient(apiKey: ForecastLoader.apiKey)
        let latitude = Double(coordinates.latitude)
        let longitude = Double(coordinates.longitude)
        forecastIOClient.getForecast(latitude: latitude, longitude: longitude) {
            (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                callback(T(forecast: currentForecast))
            }
        }
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
