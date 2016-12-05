import UIKit

@IBDesignable
@objc class HourlyCircleView: CircleView {
    var hour : String = "" {
        didSet { drawText(center: self.center) }
    }
    
    var temp : Int = 0 {
        didSet { drawText(center: self.center) }
    }
    
    var precip : Float = 0 {
        didSet { drawText(center: self.center) }
    }
    
    var imagePath : String = "" {
        didSet { drawText(center: self.center) }
    }

    
    @IBInspectable var textColor : UIColor = UIColor.black {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textSize : CGFloat = 12.0 {
        didSet { drawText(center: self.center) }
    }
    
    @IBInspectable var textFont : String = "Avenir" {
        didSet { drawText(center: self.center) }
    }
    
    var label : UILabel?
    
    
    override func draw(_ frame: CGRect) {
        super.draw(frame)
        let center = CGPoint(x: 3*lineWidth, y: 2*lineWidth)
        backgroundColor = UIColor.clear
        drawText(center: center)
    }
    
    var origin: CGPoint?
    var size: CGSize?
    
    private func drawText(center: CGPoint) {
        let shiftFactor = (2 * radius) - lineWidth
        origin = CGPoint(x: center.x, y: center.y)
        size = CGSize(width: shiftFactor, height: shiftFactor)
        
        drawHour()
        drawTemp();
        drawRain();
        drawImage();
    }
    
    private func drawHour(){
        var hourLabel: UILabel?
        
        hourLabel?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height*0.01,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        hourLabel = UILabel(frame: frame)
        hourLabel!.text = hour
        hourLabel!.textColor = textColor
        hourLabel!.font = UIFont(name: textFont, size: 20)
        hourLabel!.textAlignment = .center
        
        addSubview(hourLabel!)
    }
    
    private func drawTemp(){
        var tempLabel : UILabel?
        
        tempLabel?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width*0.05,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        tempLabel = UILabel(frame: frame)
        tempLabel!.text = temp.description
        tempLabel!.textColor = UIColor(red: 32/255, green: 118/255, blue: 200/255, alpha: 1)
        tempLabel!.font = UIFont(name: textFont, size: 30)
        tempLabel!.textAlignment = .center
        
        addSubview(tempLabel!)
    }
    
    private func drawRain(){
        var rain : UILabel?
        
        rain?.removeFromSuperview()
        
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height - size!.height*0.4,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        rain = UILabel(frame: frame)
        rain!.text = Int(precip).description + "%"
        rain!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        rain!.font = UIFont(name: textFont, size: 20)
        rain!.textAlignment = .center
        
        addSubview(rain!)
    }
    
    private func drawImage() {
        var image: UIImageView?
        
        image?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width - size!.width*0.05,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)

        image = UIImageView(frame: frame)
        image!.image = UIImage(named: imagePath)
        
        addSubview(image!)
    }
}
