import Foundation

public struct ColorValue {
    
    public var red : CGFloat
    public var green : CGFloat
    public var blue : CGFloat
    public var alpha : CGFloat
    
    // MARK: - Standart constructor
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    // MARK: - Constructor from Hex
    
    public init(hex: String, alpha: CGFloat = 1) {
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
    
    // MARK: - Random color
    
    public static func random() -> ColorValue {
        return ColorValue(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
    
    // MARK: - HEX validator
    
    public static func validateHEX(hex: String) -> Bool {
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
    
    // MARK: - Get RGBA
    
    public func getRGBA() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        return (red, green, blue, alpha)
    }
}
