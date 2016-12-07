import UIKit
import ForecastIO
import CoreLocation
import Prephirences


class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var yesterdayCircle: WeeklyCircleView!
    @IBOutlet weak var todayCircle: WeeklyCircleView!
    @IBOutlet weak var tomorrowCircle: WeeklyCircleView!
    @IBOutlet weak var dayAfterCircle: WeeklyCircleView!
    
    fileprivate var circleLayer : CAShapeLayer?
    var model : DaysModel? {
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
    }
    
    func displayWeather() {
        guard let model = self.model else {
            return
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
