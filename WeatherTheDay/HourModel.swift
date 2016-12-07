import Foundation
import ForecastIO
import CoreLocation

class HoursModel : Model{
    
    let hours: [HourModel]
    
    required init(forecast: Forecast) {
        let data = forecast.hourly?.data
        var hours = [HourModel]()
        var hour = Calendar.current.component(.hour, from: Date())
        
        for _ in 0 ..< 12 {
            
            let iconPath = data![hour].icon!.rawValue
            let currentTemp = Int(data![hour].temperature!)
            let chanceOfPrecip = data![hour].precipProbability!
            
            hours.append(HourModel(hour: hour, iconPath: iconPath, temp: currentTemp, chanceOfPrecip: chanceOfPrecip))
            
            hour += 1
        }
        self.hours = hours
    }
}

class HourModel {
    let hour : Int
    var hourString: String
    
    let iconPath : String
    let currentTemp : String
    let chanceOfPrecip : String
    
    
    init (hour: Int, iconPath: String, temp: Int, chanceOfPrecip: Float) {
        self.hour = hour
        if (self.hour % 12 == 0){
            self.hourString = "12"
        } else {
            self.hourString = "\(self.hour % 12)"
        }
        
        if (self.hour % 24 < 12) {
            self.hourString += " AM"
        } else {
            self.hourString += " PM"
        }
        
        self.iconPath = iconPath
        self.currentTemp = "\(temp)"
        self.chanceOfPrecip = "\(Int(chanceOfPrecip*100))"
    }
}
