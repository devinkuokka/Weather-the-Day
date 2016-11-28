import Foundation
import ForecastIO

protocol Model {
    init(forecast: Forecast)
}
