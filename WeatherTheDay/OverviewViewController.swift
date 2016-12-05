import UIKit
import ForecastIO
import CoreLocation


class OverviewViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var chanceOfPrecipCircle: InfoCircleView!
    @IBOutlet weak var descriptionCircle: InfoCircleView!
    
    fileprivate var circleLayer : CAShapeLayer?
    fileprivate var model : HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
    }
    
    
    func updateWeather() {
                ForecastLoader.getForecast(modelType: HomeModel.self) {model in
                    self.model = model
                    self.displayWeather()
                }
    }
    
    func displayWeather() {
        guard let model = self.model else {
            return
        }
        weatherImage.image = loadWeatherImage(icon: model.iconPath)
        lowTemperatureLabel.text = "\(model.currentTemp)"
        temperatureLabel.text = "\(model.lowTemp)"
        highTemperatureLabel.text = "\(model.highTemp)"
        
        
        if let precip = model.typeOfPrecip {
            switch model.chanceOfPrecip {
            case 0.01...0.5:
                chanceOfPrecipCircle.text = "\(precip.description.capitalized) Possible"
            case 0.5...0.95:
                chanceOfPrecipCircle.text = "\(precip.description.capitalized) Likely"
            case 0.90...0.99:
                chanceOfPrecipCircle.text = "\(precip.description.capitalized) Certain"
            case 1.0:
                chanceOfPrecipCircle.text = "\(precip.description.capitalized)ing Now"
            default:
                chanceOfPrecipCircle.text = "No Precipitation"
            }
        } else {
            chanceOfPrecipCircle.text = "No Precipitation"
        }
        
        
        descriptionCircle.text = model.description
    }
}

