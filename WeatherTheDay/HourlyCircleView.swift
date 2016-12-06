import UIKit

@IBDesignable
@objc class HourlyCircleView: CircleView {
    
    @IBInspectable var textColor : UIColor = UIColor.black {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textSize : CGFloat = 12.0 {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textFont : String = "Avenir" {
        didSet { drawText(center: self.center) }
    }
    
    
    var hour : String = "10 AM" {
        didSet { self.draw(self.frame) }
    }
    
    var currentTemp : String = "###" {
        didSet { self.draw(self.frame) }
    }
    
    var precip : String = "##%" {
        didSet { self.draw(self.frame) }
    }
    
    var imagePath : String = "sun" {
        didSet { self.draw(self.frame) }
    }
    
    var hourLabel : UILabel?
    var currentTempLabel : UILabel?
    var image: UIImageView?
    var precipLabel: UILabel?
    
    var origin: CGPoint?
    var size: CGSize?
    
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
        
        drawHour()
        drawTemp();
        drawPrecip();
        drawImage();
    }
    
    private func drawHour(){
        hourLabel?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height*0.01,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        hourLabel = UILabel(frame: frame)
        hourLabel!.text = hour
        hourLabel!.textColor = textColor
        hourLabel!.font = UIFont(name: textFont, size: 25)
        hourLabel!.textAlignment = .center
        
        addSubview(hourLabel!)
    }
    
    private func drawTemp(){
        currentTempLabel?.removeFromSuperview()
        let frame = CGRect(x: origin!.x,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        currentTempLabel = UILabel(frame: frame)
        currentTempLabel!.text = currentTemp
        currentTempLabel!.textColor = UIColor(red: 32/255, green: 118/255, blue: 200/255, alpha: 1)
        currentTempLabel!.font = UIFont(name: textFont, size: 35)
        currentTempLabel!.textAlignment = .center
        
        addSubview(currentTempLabel!)
    }
    
    private func drawPrecip(){
        precipLabel?.removeFromSuperview()
        
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height - size!.height*0.4,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        precipLabel = UILabel(frame: frame)
        precipLabel!.text = precip + "%"
        precipLabel!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        precipLabel!.font = UIFont(name: textFont, size: 25)
        precipLabel!.textAlignment = .center
        
        addSubview(precipLabel!)
    }
    
    private func drawImage() {
        image?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width/2 + size!.width*0.05,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)

        image = UIImageView(frame: frame)
        image!.image = loadWeatherImage(icon: imagePath)
        
        addSubview(image!)
    }
}
