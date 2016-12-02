import UIKit

@IBDesignable
@objc class HourlyCircleView: CircleView {
    var text : String = "" {
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
        
        drawHour(input: "10:00am")
        drawTemp(input: 45);
        drawWind(input: 20);
        drawImage(name: "Cloud-Lightening");
    }
    
    private func drawHour(input: String){
        var hour: UILabel?
        
        hour?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height*0.01,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        hour = UILabel(frame: frame)
        //hour!.layer.borderColor = UIColor.white.cgColor
        //hour!.layer.borderWidth = 5;
        hour!.text = input
        //167 207 76
        hour!.textColor = UIColor(red: 167/255, green: 207/255, blue: 76/255, alpha: 1)
        hour!.font = UIFont(name: textFont, size: 20)
        hour!.textAlignment = .center
        
        addSubview(hour!)
    }
    
    private func drawTemp(input: CGFloat){
        var temp : UILabel?
        
        temp?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width*0.05,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)
        temp = UILabel(frame: frame)
        temp!.text = "###"
        temp!.textColor = UIColor(red: 32/255, green: 118/255, blue: 200/255, alpha: 1)
        temp!.font = UIFont(name: textFont, size: 30)
        temp!.textAlignment = .center
        //temp!.layer.borderColor = UIColor.white.cgColor
        //temp!.layer.borderWidth = 5;
        
        addSubview(temp!)
    }
    
    private func drawWind(input: CGFloat){
        var wind : UILabel?
        
        wind?.removeFromSuperview()
        
        let frame = CGRect(x: origin!.x + size!.width*0.17,
                           y: origin!.y + size!.height - size!.height*0.37,
                           width: size!.width*0.75,
                           height: size!.height*0.33)
        
        wind = UILabel(frame: frame)
        wind!.text = input.description
        wind!.textColor = UIColor(red: 201/255, green: 74/255, blue: 22/255, alpha: 1)
        wind!.font = UIFont(name: textFont, size: 20)
        wind!.textAlignment = .center
        //wind!.layer.borderColor = UIColor.white.cgColor
        //wind!.layer.borderWidth = 5;
        
        addSubview(wind!)
    }
    
    private func drawImage(name: String) {
        var image: UIImageView?
        
        image?.removeFromSuperview()
        let frame = CGRect(x: origin!.x + size!.width - size!.width*0.05,
                           y: origin!.y + size!.height*0.25,
                           width: size!.width*0.5,
                           height: size!.height*0.5)

        image = UIImageView(frame: frame)
        //image!.layer.borderColor = UIColor.white.cgColor
        //image!.layer.borderWidth = 5;
        //image!.image = UIImage(named: name)
    }
}
