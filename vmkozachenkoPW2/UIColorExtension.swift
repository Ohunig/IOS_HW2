import UIKit

extension UIColor {
    func getRGBA() -> (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        else { return nil }
        
        return (red, green, blue, alpha)
    }
}
