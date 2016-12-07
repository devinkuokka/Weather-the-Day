import UIKit
import ForecastIO
import CoreLocation
import Prephirences
import LocationPickerViewController


class OverviewViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var chanceOfPrecipCircle: InfoCircleView!
    @IBOutlet weak var descriptionCircle: InfoCircleView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var model : HomeModel? {
        didSet { self.displayWeather() }
    }
    
    fileprivate let currentState = Prephirences.instance(forKey: "currentState")
    fileprivate var circleLayer : CAShapeLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForecastLoader.getForecast()
        updateWeather()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        updateWeather()
    }
    
    
    func updateWeather() {
//        if let model = currentState?.object(forKey: "debugHomeModel") as? HomeModel {
//            self.model = model
//        } else
        if let forecast = currentState?.object(forKey: "forecast") as? Forecast {
            self.model = HomeModel(forecast: forecast)
        }
        
        if let location = currentState?.unarchiveObject(forKey: "location") as? LocationItem {
            print(location)
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
                chanceOfPrecipCircle.text = "No Precip."
            }
        } else {
            chanceOfPrecipCircle.text = "No Precip."
        }
        
        
        descriptionCircle.text = model.description
    }
}

