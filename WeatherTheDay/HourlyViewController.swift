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
        
        fillCircle(circle: hour1, model: model.hours[0])
        fillCircle(circle: hour2, model: model.hours[1])
        fillCircle(circle: hour3, model: model.hours[2])
        fillCircle(circle: hour4, model: model.hours[3])
        fillCircle(circle: hour5, model: model.hours[4])
        fillCircle(circle: hour6, model: model.hours[5])
        fillCircle(circle: hour7, model: model.hours[6])
        fillCircle(circle: hour8, model: model.hours[7])
        fillCircle(circle: hour9, model: model.hours[8])
        fillCircle(circle: hour10, model: model.hours[9])
        fillCircle(circle: hour11, model: model.hours[10])
        fillCircle(circle: hour12, model: model.hours[11])
    }
    
    func fillCircle(circle: HourlyCircleView, model: HourModel){
        DispatchQueue.main.async(){
            circle.hour = model.hourString
            circle.currentTemp = model.currentTemp
            circle.imagePath = model.iconPath
            circle.precip = model.chanceOfPrecip
        }
    }
}

