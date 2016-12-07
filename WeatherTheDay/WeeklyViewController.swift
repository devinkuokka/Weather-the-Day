import UIKit
import ForecastIO
import CoreLocation
import LocationPickerViewController
import Prephirences


class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var yesterdayCircle: WeeklyCircleView!
    @IBOutlet weak var todayCircle: WeeklyCircleView!
    @IBOutlet weak var tomorrowCircle: WeeklyCircleView!
    @IBOutlet weak var dayAfterCircle: WeeklyCircleView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    fileprivate var circleLayer : CAShapeLayer?
    var model : DaysModel? {
        didSet { self.displayWeather() }
    }
    var yesterdayModel : yesterdaysModel? {
        didSet { self.displayWeather() }
    }
    
    fileprivate let currentState = Prephirences.instance(forKey: "currentState")
    
    
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
        if let forecast = currentState?.object(forKey: "forecast") as? Forecast {
            self.model = DaysModel(forecast: forecast)
        }
        if let forecast = currentState?.object(forKey: "yesterday") as? Forecast {
            self.yesterdayModel = yesterdaysModel(forecast: forecast)
        }
    }
    
    func displayWeather() {
        guard let model = self.model,
              let yesterdayModel = self.yesterdayModel else {
            return
        }
        
        
        DispatchQueue.main.async(){
            if let location = self.currentState?.unarchiveObject(forKey: "location") as? LocationItem {
               self.locationLabel.text = location.name
            }
            
            self.yesterdayCircle.imagePath = yesterdayModel.days[0].iconPath
            self.yesterdayCircle.currentTemp = "\(yesterdayModel.days[0].currentTemp)"
            self.yesterdayCircle.lowTemp = "\(yesterdayModel.days[0].lowTemp)"
            self.yesterdayCircle.highTemp = "\(yesterdayModel.days[0].highTemp)"
        }
        
        fillCircle(circle: todayCircle, model: model.days[0])
        fillCircle(circle: tomorrowCircle, model: model.days[1])
        fillCircle(circle: dayAfterCircle, model: model.days[2])
    }
    
    func fillCircle(circle: WeeklyCircleView, model: DayModel){
        DispatchQueue.main.async(){
            circle.imagePath = model.iconPath
            circle.currentTemp = "\(model.currentTemp)"
            circle.lowTemp = "\(model.lowTemp)"
            circle.highTemp = "\(model.highTemp)"
        }
    }
}
