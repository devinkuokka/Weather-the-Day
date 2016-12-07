import UIKit
import ForecastIO
import CoreLocation
import Prephirences
import LocationPickerViewController

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
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    fileprivate let currentState = Prephirences.instance(forKey: "currentState")
    fileprivate var circleLayer : CAShapeLayer?
    
    var model : HoursModel? {
        didSet { self.displayWeather() }
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        updateWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ForecastLoader.getForecast()
        updateWeather()
    }
    
    
    func updateWeather() {
        if let forecast = currentState?.object(forKey: "forecast") as? Forecast {
            self.model = HoursModel(forecast: forecast)
        }
    }
    
    func displayWeather() {
        guard let model = self.model else {
            return
        }
        DispatchQueue.main.async(){
            if let location = self.currentState?.unarchiveObject(forKey: "location") as? LocationItem {
                self.locationLabel.text = location.name
            }
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

