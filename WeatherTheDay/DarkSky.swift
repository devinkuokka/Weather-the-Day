import Foundation
import ForecastIO

func loadWeatherImage(icon: String) -> UIImage {
    return UIImage(named: findWeatherImageString(icon: icon))!
   
}

fileprivate func findWeatherImageString(icon: String) -> String {
    switch icon {
    case "clear-day":
        return "Sun"
    case "clear-night":
        return "Moon"
    case "rain":
        return "Cloud-Rain"
    case "snow":
        return "Snowflake"
    case "sleet":
        return "Cloud-Hail"
    case "wind":
        return "Cloud-Wind"
    case "fog":
        return "Cloud-Fog"
    case "cloudy":
        return "Cloud"
    case "partly-cloudy-day":
        return "Cloud-Sun"
    case "partly-cloudy-night":
        return "Cloud-Moon"
    default:
        return icon.capitalized
    }
}
