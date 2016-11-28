import UIKit
import ForecastIO
import CoreLocation


class OverviewViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var chanceOfRainCircle: InfoCircleView!
    @IBOutlet weak var chanceOfHellfireCircle: InfoCircleView!
    @IBOutlet weak var chanceOfSnowCircle: InfoCircleView!
    
    fileprivate var circleLayer : CAShapeLayer?
    fileprivate var model : HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
    }
    
    
    func updateWeather() {
        //        ForecastLoader.getForecast(modelType: HomeModel.self) {model in
        //            self.model = model
        //            self.displayWeather()
        //        }
        
        self.model = HomeModel(latitude: 12.12,
                               longitude: 12.12,
                               description: "Sunny or rainy.",
                               iconPath: "clear-night",
                               temp: 77,
                               low: 30,
                               high: 90,
                               chanceOfPrecip: 0.3,
                               minutesUntilPrecip: 10,
                               typeOfPrecip: .Rain)
        self.displayWeather()
    }
    
    func displayWeather() {
        guard let model = self.model else {
            return
        }
        weatherImage.image = loadWeatherImage(icon: model.iconPath)
        lowTemperatureLabel.text = "\(model.currentTemp)"
        temperatureLabel.text = "\(model.lowTemp)"
        highTemperatureLabel.text = "\(model.highTemp)"
        chanceOfRainCircle.text = "\(10 * model.chanceOfPrecip)% Chance of \(model.typeOfPrecip!.description.capitalized)"
        chanceOfHellfireCircle.text = "\(10 * model.chanceOfPrecip)% Chance of Hellfire"
        chanceOfSnowCircle.text = "\(10 * model.chanceOfPrecip)% Chance of Snow"
    }
    
    
    
}

