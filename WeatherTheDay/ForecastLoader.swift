import Foundation
import CoreLocation
import Prephirences
import LocationPickerViewController
import ForecastIO

class ForecastLoader {
    static fileprivate let apiKey = "06afa3d18acac1c10822fec658f162ea"
    static fileprivate let currentState = Prephirences.instance(forKey: "currentState") as! MutablePreferencesType
    static fileprivate let locationManager = loadLocationManager()
    static fileprivate var forecast : Forecast?
    
    public static func getForecast() {
        let lat : Float
        let lon : Float
        
        if let location = currentState.unarchiveObject(forKey: "location") as? LocationItem {
            lat = Float(location.coordinate!.latitude)
            lon = Float(location.coordinate!.longitude)
        } else {
            let coordinates = locationManager.location?.coordinate
            lat = Float((coordinates?.latitude)!)
            lon = Float((coordinates?.longitude)!)
        }
        

        if let previousForecast = currentState.object(forKey: "forecast") as? Forecast {
            
            let prevLat = Float(previousForecast.latitude)
            let prevLon = Float(previousForecast.longitude)
            

            
            if ( lat != prevLat || lon != prevLon) {
                getForecast(latitude: lat,
                            longitude: lon,
                            callback: { currentState.set($0, forKey: "forecast") },
                            secondCallback: { currentState.set($0, forKey: "yesterday")})
            }
        } else {
            getForecast(latitude: lat,
                        longitude: lon,
                        callback: { currentState.set($0, forKey: "forecast") },
                        secondCallback: { currentState.set($0, forKey: "yesterday")})
        }
        
        
        
    }
    
    
    fileprivate static func getForecast(latitude: Float, longitude: Float, callback: @escaping (Forecast) -> Void, secondCallback: @escaping (Forecast) -> Void) {
        let forecastIOClient = APIClient(apiKey: ForecastLoader.apiKey)
        
        forecastIOClient.getForecast(latitude: Double(latitude), longitude: Double(longitude), extendHourly: true, excludeForecastFields: []) {
            (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                callback(currentForecast)
            }
        }
        
        let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        forecastIOClient.getForecast(latitude: Double(latitude), longitude: Double(longitude), time: yesterday) {
            (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                secondCallback(currentForecast)
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
