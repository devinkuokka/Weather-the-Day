import UIKit

@IBDesignable
@objc class WeeklyCircleView: CircleView {
    @IBInspectable var textColor : UIColor = UIColor.black {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textSize : CGFloat = 12.0 {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textFont : String = "Avenir" {
        didSet { drawText(center: self.center) }
    }
    
    var currentTemp : String = "###" {
        didSet { self.draw(self.frame) }
    }
    
    var imagePath: String = "" {
        didSet { self.draw(self.frame) }
    }
    
    var highTemp : String = "###" {
        didSet { self.draw(self.frame)}
    }
    
    var lowTemp : String = "###" {
        didSet { self.draw(self.frame)      }
    }

    var origin: CGPoint?
    var size: CGSize?
    
    var currentTempLabel : UILabel?
    var lowTempLabel : UILabel?
    var highTempLabel : UILabel?
    var image: UIImageView?
    
    var oldFrame : CGRect?
    
    override func draw(_ frame: CGRect) {
        if oldFrame == nil {
            oldFrame = frame
        }
         super.draw(oldFrame!)
        
        let center = CGPoint(x: 3*lineWidth, y: 2*lineWidth)
        backgroundColor = UIColor.clear
        drawText(center: center)
    }
    
    
    private func drawText(center: CGPoint) {
        let shiftFactor = (2 * radius) - lineWidth
        origin = CGPoint(x: center.x, y: center.y)
        size = CGSize(width: shiftFactor, height: shiftFactor)
        
        drawTemp()
        drawImage()
        drawLowLabel()
        drawHighLabel()
        drawLowTemp()
        drawHighTemp()
    }
    
    func drawTemp(){
        currentTempLabel?.removeFromSuperview()
        let frame = CGRect(x: size!.width*0.5 - size!.width*0.1,
                           y: size!.height*0.66,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        currentTempLabel = UILabel(frame: frame)
        currentTempLabel!.text = currentTemp
        currentTempLabel!.textColor = UIColor(red: 32/255, green: 118/255, blue: 200/255, alpha: 1)
        currentTempLabel!.font = UIFont(name: textFont, size: 50)
        currentTempLabel!.textAlignment = .center
    
        addSubview(currentTempLabel!)
    }
    
    private func drawImage() {
        image?.removeFromSuperview()
        let frame = CGRect(x: size!.width*0.5 - size!.width*0.1,
                           y: origin!.y - size!.height*0.1,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        image = UIImageView(frame: frame)
        image!.image = loadWeatherImage(icon: imagePath)
        
        addSubview(image!)
    }
    
    func drawLowLabel(){
        let frame = CGRect(x: origin!.x,
                           y: origin!.y + size!.height*0.15,
                           width: 1.5*(size!.width*0.25),
                           height: size!.height*0.5)
        
        let lowLabel = UILabel(frame: frame)
        lowLabel.text = "Low"
        lowLabel.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        lowLabel.font = UIFont(name: textFont, size: 20)
        lowLabel.textAlignment = .center
        
        addSubview(lowLabel)
    }
    
    func drawHighLabel(){
        let frame = CGRect(x: size!.width*0.75,
                           y: origin!.y + size!.height*0.15,
                           width: 1.5*(size!.width*0.25),
                           height: size!.height*0.5)
        
        let highLabel = UILabel(frame: frame)
        highLabel.text = "High"
        highLabel.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        highLabel.font = UIFont(name: textFont, size: 20)
        highLabel.textAlignment = .center
        
        addSubview(highLabel)
    }

    func drawLowTemp(){
        lowTempLabel?.removeFromSuperview()
        let frame = CGRect(x: origin!.x,
                           y: origin!.y + size!.height*0.3,
                           width: 1.5*(size!.width*0.25),
                           height: size!.height*0.5)
        
        lowTempLabel = UILabel(frame: frame)
        lowTempLabel!.text = lowTemp
        lowTempLabel!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        lowTempLabel!.font = UIFont(name: textFont, size: 30)
        lowTempLabel!.textAlignment = .center
        
        addSubview(lowTempLabel!)
    }
    
    func drawHighTemp(){
        highTempLabel?.removeFromSuperview()
        let frame = CGRect(x: size!.width*0.75,
                           y: origin!.y + size!.height*0.3,
                           width: 1.5*(size!.width*0.25),
                           height: size!.height*0.5)
        
        highTempLabel = UILabel(frame: frame)
        highTempLabel!.text = highTemp
        highTempLabel!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        highTempLabel!.font = UIFont(name: textFont, size: 30)
        highTempLabel!.textAlignment = .center
        
        addSubview(highTempLabel!)
    }

}
