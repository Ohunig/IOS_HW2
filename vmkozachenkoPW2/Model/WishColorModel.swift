import Foundation

final class WishColorModel {
    
    var onColorChanged: ((ColorValue) -> Void)?
    
    private(set) var color = ColorValue(red: 0, green: 0, blue: 0) {
        didSet { onColorChanged?(color) }
    }
    
    // MARK: - Api
    
    func setColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        color = ColorValue(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func setColor(hex: String, alpha: CGFloat = 1) {
        guard ColorValue.validateHEX(hex: hex) else { return }
        color = ColorValue(hex: hex, alpha: alpha)
    }
    
    func setRandomColor() {
        color = ColorValue.random()
    }
}
