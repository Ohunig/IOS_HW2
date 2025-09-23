import UIKit

extension UIColor {
    
    // MARK: - Constructor from Hex
    
    convenience init(hex: String, alpha: Float = 1) {
        // think that we have correct hex
        let hexInt = Int(hex.suffix(hex.count - 1), radix: 16) ?? 0
        // two in the eighth degree minus one
        let module = 255
        self.init(
            red: CGFloat(Float(hexInt >> 16) / Float(module)),
            green: CGFloat(Float((hexInt >> 8) & module) / Float(module)),
            blue: CGFloat(Float(hexInt & module) / Float(module)),
            alpha: CGFloat(alpha))
    }
    
    // MARK: - HEX validator
    
    static func validateHEX(hex: String) -> Bool {
        if (hex.count != 7 || hex[hex.startIndex] != "#") {
            return false;
        }
        let hexSuff = hex.suffix(hex.count - 1)
        for symbol in hexSuff {
            if !("0"..."9").contains(symbol) && !("a"..."f").contains(symbol) && !("A"..."F").contains(symbol) {
                return false
            }
        }
        return true;
    }
    
    // MARK: - RGBA getter
    
    func getRGBA() -> (CGFloat, CGFloat, CGFloat, CGFloat)? {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        // get all colors
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        else { return nil }
        
        return (red, green, blue, alpha)
    }
}
