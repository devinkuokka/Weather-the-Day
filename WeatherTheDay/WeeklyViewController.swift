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
        
        fillCircle(circle: todayCircle, day: 0, model: model)
        fillCircle(circle: tomorrowCircle, day: 1, model: model)
        fillCircle(circle: dayAfterCircle, day: 2, model: model)
    }
    
    func fillCircle(circle: WeeklyCircleView, day: Int, model: DaysModel){
        circle.imagePath = model.days[day].iconPath
        circle.temp = model.days[day].currentTemp.description
        circle.lowTemp = "\(model.days[day].lowTemp)"
        circle.highTemp = "\(model.days[day].highTemp)"
    }
}
