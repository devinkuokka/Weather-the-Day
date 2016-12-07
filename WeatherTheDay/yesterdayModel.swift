import Foundation
import ForecastIO
import CoreLocation

class yesterdaysModel : Model {
    
    let days: [yesterdayModel]
    
    required init(forecast: Forecast) {
        let day = forecast.daily!.data!
        let hourly = forecast.hourly!.data!
        
        var days = [yesterdayModel]()
            
        let iconPath = day[0].icon!.rawValue
        let lowTemp = Int(day[0].temperatureMin!)
        let highTemp = Int(day[0].temperatureMax!)
        let currentTemp = Int(hourly[0].apparentTemperature!)
            
        days.append(yesterdayModel(iconPath: iconPath, temp: Int(currentTemp), low: lowTemp,
                            high: highTemp))
        
        self.days = days
    }
}

class yesterdayModel {
    
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
