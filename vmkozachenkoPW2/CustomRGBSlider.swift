import UIKit

final class CustomRGBSlider : UIView {
    
    // MARK: - Constants
    
    enum Constants {
        static let stackCornerRadius : CGFloat = 20
        
        static let redSliderTitle = "Red"
        static let greenSliderTitle = "Green"
        static let blueSliderTitle = "Blue"
        
        static let sliderMin : CGFloat = 0
        static let sliderMax : CGFloat = 255
        
        static let maxColorVal : CGFloat = 255
    }
    
    // MARK: - Fields
    
    let slidersStack = UIStackView()
    
    let redSlider = CustomSlider(title: Constants.redSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
    let greenSlider = CustomSlider(title: Constants.greenSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
    let blueSlider = CustomSlider(title: Constants.blueSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
    
    // MARK: - Initialisers
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        // set stack settings
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.layer.cornerRadius = Constants.stackCornerRadius
        slidersStack.clipsToBounds = true
        slidersStack.axis = .vertical
        self.addSubview(slidersStack)
        
        // add sliders to slidersStack view
        for slider in [redSlider, greenSlider, blueSlider] {
            slider.translatesAutoresizingMaskIntoConstraints = false
            slidersStack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            slidersStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slidersStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            slidersStack.topAnchor.constraint(equalTo: self.topAnchor),
            slidersStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Update colors
    
    func updateColors(_ color: (CGFloat, CGFloat, CGFloat, CGFloat)?) {
        guard let color = color else { return }
        redSlider.setValue(value: color.0 * Constants.maxColorVal)
        greenSlider.setValue(value: color.1 * Constants.maxColorVal)
        blueSlider.setValue(value: color.2 * Constants.maxColorVal)
    }
}
