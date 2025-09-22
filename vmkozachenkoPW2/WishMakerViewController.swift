import UIKit

final class WishMakerViewController : UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let titleText = "Wish Maker"
        static let titleFontSize : CGFloat = 40
        static let titleLeading : CGFloat = 20
        static let titleTop : CGFloat = 20
        
        static let descriptionText = "This app will bring you joy and will fulfill three of your wishes!\n\t*The first wish is to change the background title."
        static let descriptionFontSize : CGFloat = 20
        static let descriptionLeading : CGFloat = 20
        static let descriptionTop : CGFloat = 50
        
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
    
    let mainTitle = UILabel()
    let mainDescription = UILabel()
    let slidersStack = UIStackView()
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureDescription()
        configureSliders()
    }
    
    // MARK: - Configure Title
    
    private func configureTitle() {
        // customise title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.text = Constants.titleText
        mainTitle.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        mainTitle.textColor = .orange
        
        // place title on view
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.titleLeading),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop),
        ])
    }
    
    // MARK: - Configure description
    
    private func configureDescription() {
        // customise description
        mainDescription.translatesAutoresizingMaskIntoConstraints = false
        mainDescription.text = Constants.descriptionText
        mainDescription.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        mainDescription.textColor = .orange
        mainDescription.numberOfLines = 0
        
        // place description on view
        view.addSubview(mainDescription)
        NSLayoutConstraint.activate([
            mainDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLeading),
            mainDescription.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: Constants.descriptionTop)
        ])
    }
    
    // MARK: - Configure Sliders
    
    private func configureSliders() {
        // set stack settings
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.layer.cornerRadius = Constants.stackCornerRadius
        slidersStack.clipsToBounds = true
        slidersStack.axis = .vertical
        view.addSubview(slidersStack)
        
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
        
        // add sliders to slidersStack view
        for slider in [redSlider, greenSlider, blueSlider] {
            slider.translatesAutoresizingMaskIntoConstraints = false
            slidersStack.addArrangedSubview(slider)
        }
        
        // set constraints to slidersStack
        NSLayoutConstraint.activate([
            slidersStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slidersStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.stackBottom),
            slidersStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading)
        ])
    }
}
