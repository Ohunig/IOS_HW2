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
        
        static let stackLeading : CGFloat = 20
        static let stackTop : CGFloat = 30
        
        static let maxColorVal : CGFloat = 255
        
        static let textFieldPlaceholder = "Write hex color"
        static let textFieldLeading : CGFloat = 50
        
        static let randomButtonTitle = "Random"
        static let randomButtonLeading : CGFloat = 100
        static let randomButtonHeight : CGFloat = 40
        
        static let segmentedControlFirst = "Picker"
        static let segmentedControlSecond = "HEX"
        static let segmentedControlThird = "Random"
        static let segmentedControlLeading : CGFloat = 30
        static let segmentedControlBottom : CGFloat = -50
        static let segmetedControlSelectedSegmentIndex = 0
    }
    
    // MARK: - Fields
    
    let model = WishColorModel()
    
    let mainTitle = UILabel()
    let mainDescription = UILabel()
    
    let segmentedControl = UISegmentedControl()
    
    // Color controllers
    let rgbSlider = CustomRGBSlider()
    let textField = CustomTextField(placeholder: Constants.textFieldPlaceholder)
    let randomButton = UIButton(type: .system)
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.onColorChanged = { [weak self] color in
            self?.view.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureSliders()
        configureTextField()
        configureRandomButton()
        configureSegmentedControl()
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
        
        // assign what valueChanged do to all our sliders
        rgbSlider.redSlider.ValueChanged = { [weak self] value in
            guard let self = self else { return }
            let normalisedValue = value / Constants.maxColorVal
            let (_, green, blue, alpha) = self.model.color.getRGBA()
            self.model.setColor(red: normalisedValue, green: green, blue: blue, alpha: alpha)
        }
        
        rgbSlider.greenSlider.ValueChanged = { [weak self] value in
            guard let self = self else { return }
            let normalisedValue = value / Constants.maxColorVal
            let (red, _, blue, alpha) = self.model.color.getRGBA()
            self.model.setColor(red: red, green: normalisedValue, blue: blue, alpha: alpha)
        }
        
        rgbSlider.blueSlider.ValueChanged = { [weak self] value in
            guard let self = self else { return }
            let normalisedValue = value / Constants.maxColorVal
            let (red, green, _, alpha) = self.model.color.getRGBA()
            self.model.setColor(red: red, green: green, blue: normalisedValue, alpha: alpha)
        }
        
        // update rgbSlider's colors
        rgbSlider.updateColors(self.model.color.getRGBA())
        
        // add rgbSlider to view
        rgbSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rgbSlider)
        NSLayoutConstraint.activate([
            rgbSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rgbSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rgbSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            rgbSlider.topAnchor.constraint(greaterThanOrEqualTo: mainDescription.bottomAnchor, constant: Constants.stackTop)
        ])
    }
    
    // MARK: - Configure Text Field
    
    private func configureTextField() {
        
        textField.buttonPressed = { [weak self] in
            guard let self = self else { return }
            
            self.dismissKeyboard()
            
            let hex = self.textField.getText()
            self.model.setColor(hex: hex)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.textFieldLeading)
        ])
    }
    
    // MARK: - Configure random button
    
    private func configureRandomButton() {
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchDown)
        randomButton.backgroundColor = .orange
        randomButton.setTitle(Constants.randomButtonTitle, for: .normal)
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.translatesAutoresizingMaskIntoConstraints = false;
        
        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            randomButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.randomButtonLeading),
            randomButton.heightAnchor.constraint(equalToConstant: Constants.randomButtonHeight)
            
        ])
    }
    
    // MARK: - Configure seg control
    
    private func configureSegmentedControl() {
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .orange
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.insertSegment(withTitle: Constants.segmentedControlFirst, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Constants.segmentedControlSecond, at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: Constants.segmentedControlThird, at: 2, animated: false)
        
        
        segmentedControl.selectedSegmentIndex = Constants.segmetedControlSelectedSegmentIndex
        textField.isHidden = true
        randomButton.isHidden = true
        
        segmentedControl.addTarget(self, action: #selector(segmentControlTapped), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.segmentedControlLeading),
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.segmentedControlBottom)
        ])
    }
    
    // MARK: - Random button tapped
    
    @objc
    private func randomButtonTapped() {
        let color = ColorValue.random()
        model.setColor(red: color.red, green: color.green, blue: color.blue)
    }
    
    // MARK: - Segment control tapped
    
    @objc
    private func segmentControlTapped() {
        // hide all controllers
        for controller in [rgbSlider, textField, randomButton] {
            controller.isHidden = true;
        }
        // select one
        let mode = segmentedControl.selectedSegmentIndex
        switch mode {
        case 0:
            rgbSlider.updateColors(model.color.getRGBA())
            rgbSlider.isHidden = false;
        case 1:
            textField.isHidden = false;
        case 2:
            randomButton.isHidden = false;
        default:
            break
        }
    }
    
    // MARK: - Dismiss Keyboard
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
