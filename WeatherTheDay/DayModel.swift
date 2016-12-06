import Foundation
import ForecastIO
import CoreLocation

class DaysModel : Model {
    
    let days: [DayModel]
    
    required init(forecast: Forecast) {
        let day = forecast.daily!.data!
        let hourly = forecast.hourly!.data!
        var days = [DayModel]()
        
        print (hourly.count)
        
        var currentTemp = [Float]()
        currentTemp.append(0)
        currentTemp.append(0)
        currentTemp.append(0)
        
        var hourCounter = 1
        var dayCounter = 0
        var i = 1
        while i < 70 {
            if (hourCounter == 16) {
                hourCounter = 1
                i += 9
                dayCounter += 1
                print()
            } else {
                print(hourly[i].time)
                currentTemp[dayCounter] += hourly[i].temperature!
                hourCounter += 1
                i += 1
            }
        }
        
        
        for i in 0..<3 {
        
            let iconPath = day[i].icon!.rawValue
            let lowTemp = Int(day[i].temperatureMin!)
            let highTemp = Int(day[i].temperatureMax!)
            
            days.append(DayModel(iconPath: iconPath, temp: Int(currentTemp[i]/15), low: lowTemp,
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
