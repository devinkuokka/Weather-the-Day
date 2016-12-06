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
    let hourString: String
    
    let iconPath : String
    let currentTemp : String
    let chanceOfPrecip : String
    
    
    init (hour: Int, iconPath: String, temp: Int, chanceOfPrecip: Float) {
        self.hour = hour
        if (self.hour > 12){
            self.hourString = (self.hour - 12).description + " PM"
        } else if (self.hour == 12){
            self.hourString = self.hour.description + " PM"
        } else if (self.hour == 0) {
            self.hourString = "12 AM"
        } else {
            self.hourString = self.hour.description + " AM"
        }
        
        self.iconPath = iconPath
        self.currentTemp = "\(temp)"
        self.chanceOfPrecip = "\(Int(chanceOfPrecip))"
    }
}
