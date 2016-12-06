import UIKit
import ForecastIO
import CoreLocation


class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var yesterdayCircle: WeeklyCircleView!
    @IBOutlet weak var todayCircle: WeeklyCircleView!
    @IBOutlet weak var tomorrowCircle: WeeklyCircleView!
    @IBOutlet weak var dayAfterCircle: WeeklyCircleView!
    
    fileprivate var circleLayer : CAShapeLayer?
    fileprivate var model : DaysModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
    }
    
    
    func updateWeather() {
        ForecastLoader.getForecast(modelType: DaysModel.self) {model in
            self.model = model
            self.displayWeather()
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
