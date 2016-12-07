import Foundation
import ForecastIO
import CoreLocation

class DaysModel : Model {
    
    let days: [DayModel]
    
    required init(forecast: Forecast) {
        let day = forecast.daily!.data!
        let hourly = forecast.hourly!.data!
        
        var days = [DayModel]()
        
        for i in 0..<3 {
        
            let iconPath = day[i].icon!.rawValue
            let lowTemp = Int(day[i].temperatureMin!)
            let highTemp = Int(day[i].temperatureMax!)
            let currentTemp = Int(hourly[i*24].apparentTemperature!)
            
            days.append(DayModel(iconPath: iconPath, temp: Int(currentTemp), low: lowTemp,
                                 high: highTemp))
        }
        
        self.days = days
    }
}

class DayModel {
    
    let iconPath : String
    let currentTemp : Int
    let lowTemp : Int
    let highTemp : Int
    
    init (iconPath: String, temp: Int, low: Int, high: Int) {
        self.iconPath = iconPath
        self.currentTemp = temp
        self.lowTemp = low
        self.highTemp = high
    }
}
