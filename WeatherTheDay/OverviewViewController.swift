import UIKit
import ForecastIO
import CoreLocation


class OverviewViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
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
        let center = midpoint(a: weatherImage.center, b: temperatureLabel.center)
        drawCircle(center: center, radius: weatherImage.image!.size.width / 10 * 1.5)
        
        lowTemperatureLabel.text = "\(model.currentTemp)"
        temperatureLabel.text = "\(model.lowTemp)"
        highTemperatureLabel.text = "\(model.highTemp)"
    }
    
    
    func drawCircle(center: CGPoint,
                    radius: CGFloat,
                    fillColor: UIColor=UIColor.clear,
                    strokeColor: UIColor=UIColor.black) {
        let newCenter = CGPoint(x: center.x, y: center.y)
        let circlePath = UIBezierPath(arcCenter: newCenter,
                                      radius: radius,
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(M_PI * 2),
                                      clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 10.0
        circleLayer = shapeLayer
        view.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func midpoint(a: CGPoint, b: CGPoint) -> CGPoint{
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}

