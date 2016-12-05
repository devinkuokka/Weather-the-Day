import UIKit
import ForecastIO
import CoreLocation


class HourlyViewController: UIViewController {
    
    @IBOutlet weak var hour1: HourlyCircleView!
    @IBOutlet weak var hour2: HourlyCircleView!
    @IBOutlet weak var hour3: HourlyCircleView!
    @IBOutlet weak var hour4: HourlyCircleView!
    @IBOutlet weak var hour5: HourlyCircleView!
    @IBOutlet weak var hour6: HourlyCircleView!
    @IBOutlet weak var hour7: HourlyCircleView!
    @IBOutlet weak var hour8: HourlyCircleView!
    @IBOutlet weak var hour9: HourlyCircleView!
    @IBOutlet weak var hour10: HourlyCircleView!
    @IBOutlet weak var hour11: HourlyCircleView!
    @IBOutlet weak var hour12: HourlyCircleView!
    
    
    fileprivate var circleLayer : CAShapeLayer?
    fileprivate var model : HoursModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWeather()
    }
    
    
    func updateWeather() {
        ForecastLoader.getForecast(modelType: HoursModel.self) {model in
            self.model = model
            self.displayWeather()
        }
    }
    
    func displayWeather() {
        guard let model = self.model else {
            return
        }
        
        fillCircle(circle: hour1, hour: 0, model: model)
        fillCircle(circle: hour2, hour: 1, model: model)
        fillCircle(circle: hour3, hour: 2, model: model)
        fillCircle(circle: hour4, hour: 3, model: model)
        fillCircle(circle: hour5, hour: 4, model: model)
        fillCircle(circle: hour6, hour: 5, model: model)
        fillCircle(circle: hour7, hour: 6, model: model)
        fillCircle(circle: hour8, hour: 7, model: model)
        fillCircle(circle: hour9, hour: 8, model: model)
        fillCircle(circle: hour10, hour: 9, model: model)
        fillCircle(circle: hour11, hour: 10, model: model)
        fillCircle(circle: hour12, hour: 11, model: model)
    }
    
    func fillCircle(circle: HourlyCircleView, hour: Int, model: HoursModel){
        
        circle.hour = model.hours[hour].hourString
        circle.temp = model.hours[hour].currentTemp
        circle.imagePath = model.hours[hour].iconPath
        circle.precip = model.hours[hour].chanceOfPrecip
    }
}

