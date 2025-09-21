import UIKit

final class WishMakerViewController : UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let titleFontSize : CGFloat = 40
        static let titleLeading : CGFloat = 20
        static let titleTop : CGFloat = 20
        
        static let stackCornerRadius : CGFloat = 20
        static let stackBottom : CGFloat = -50
        static let stackLeading : CGFloat = 20
        
        static let redSliderTitle = "Red"
        static let greenSliderTitle = "Green"
        static let blueSliderTitle = "Blue"
        
        static let sliderMin : CGFloat = 0
        static let sliderMax : CGFloat = 255
        
        static let maxColorVal : Double = 255
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureSliders()
    }
    
    // MARK: - Configure Title
    
    private func configureTitle() {
        // initialize and customise title
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Wish Maker"
        title.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        title.textColor = .orange
        
        // place title on view
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.titleLeading),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    // MARK: - Configure Sliders
    
    private func configureSliders() {
        let stack = UIStackView()
        // set stack settings
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        stack.axis = .vertical
        view.addSubview(stack)
        
        // initialise sliders
        let redSlider = CustomSlider(title: Constants.redSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
        let greenSlider = CustomSlider(title: Constants.greenSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
        let blueSlider = CustomSlider(title: Constants.blueSliderTitle, minValue: Constants.sliderMin, maxValue: Constants.sliderMax)
        
        // assign what valueChanged do to all our sliders
        
        redSlider.ValueChanged = { [weak self] value in
            guard let (_, green, blue, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: normalisedValue, green: green, blue: blue, alpha: alpha)
        }
        
        greenSlider.ValueChanged = { [weak self] value in
            guard let (red, _, blue, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: red, green: normalisedValue, blue: blue, alpha: alpha)
        }
        
        blueSlider.ValueChanged = { [weak self] value in
            guard let (red, green, _, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: red, green: green, blue: normalisedValue, alpha: alpha)
        }
        
        // add sliders to stack view
        for slider in [redSlider, greenSlider, blueSlider] {
            slider.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(slider)
        }
        
        // set constraints to stack
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.stackBottom),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading)
        ])
    }
}
