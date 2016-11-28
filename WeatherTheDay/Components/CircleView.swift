import UIKit

@IBDesignable
class CircleView: UIView {
    var radius : CGFloat = 0.0
    
    @IBInspectable var fillColor : UIColor = UIColor.clear {
        didSet { drawCircle(center: self.center) }
    }
    
    @IBInspectable var strokeColor : UIColor = UIColor.black {
        didSet { drawCircle(center: self.center) }
    }
    
    @IBInspectable var lineWidth : CGFloat = 10.0 {
        didSet { drawCircle(center: self.center) }
    }

    let shapeLayer = CAShapeLayer()
    
    override func draw(_ frame: CGRect) {
        self.radius = (min(frame.height, frame.width) / 2) * 0.9
        let center = CGPoint(x: frame.midX, y: frame.midY)
        backgroundColor = UIColor.clear
        drawCircle(center: center)
    }

    
    private func drawCircle(center: CGPoint) {
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: 0.0,
                                      endAngle: CGFloat(M_PI * 2),
                                      clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = lineWidth
        if layer.sublayers == nil || layer.sublayers!.isEmpty {
            layer.addSublayer(shapeLayer)
        }
    }
    
    fileprivate func midpoint(a: CGPoint, b: CGPoint) -> CGPoint{
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }
    
}
