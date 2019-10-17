import UIKit

extension UIView {
    func round(corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], with radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func setTypeBackgroundColor(for type: String, rotation: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "\(type)-1")!.cgColor, UIColor(named: "\(type)-2")!.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(rotation, 0, 0, 1)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
