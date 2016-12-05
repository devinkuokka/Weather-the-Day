import Foundation
import ForecastIO
import CoreLocation

class DaysModel : Model {
    
    let days: [DayModel]
    
    required init(forecast: Forecast) {
        let day = forecast.daily!.data!
        var days = [DayModel]()
        
        for i in 0..<3 {
        
            let iconPath = day[i].icon!.rawValue
            let currentTemp = Int(day[i].temperature!)
            let lowTemp = Int(day[i].temperatureMin!)
            let highTemp = Int(day[i].temperatureMax!)
            
            days.append(DayModel(iconPath: iconPath, temp: currentTemp, low: lowTemp,
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
