import UIKit

final class WishMakerViewController : UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let viewColor = "#123456"
        
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
        
        static let segmentedControlFirst = "Picker"
        static let segmentedControlSecond = "HEX"
        static let segmentedControlThird = "Random"
        static let segmentedControlLeading : CGFloat = 30
        static let segmentedControlBottom : CGFloat = -50
        static let segmetedControlSelectedSegmentIndex = 0
    }
    
    // MARK: - Fields
    
    let mainTitle = UILabel()
    let mainDescription = UILabel()
    
    // Segmented control
    let segmentedControl = UISegmentedControl()
    
    // Color controllers
    let rgbSlider = CustomRGBSlider()
    let textField = CustomTextField(placeholder: Constants.textFieldPlaceholder)
    let randomButton = UIButton(type: .system)
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        configureUI()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        view.backgroundColor = UIColor(hex: Constants.viewColor)
        configureTitle()
        configureDescription()
        configureSliders()
        configureTextField()
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
            guard let (_, green, blue, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: normalisedValue, green: green, blue: blue, alpha: alpha)
        }
        
        rgbSlider.greenSlider.ValueChanged = { [weak self] value in
            guard let (red, _, blue, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: red, green: normalisedValue, blue: blue, alpha: alpha)
        }
        
        rgbSlider.blueSlider.ValueChanged = { [weak self] value in
            guard let (red, green, _, alpha) = self?.view.backgroundColor?.getRGBA()
            else { return }
            let normalisedValue = value / Constants.maxColorVal
            self?.view.backgroundColor = .init(red: red, green: green, blue: normalisedValue, alpha: alpha)
        }
        
        // update rgbSlider's colors
        rgbSlider.updateColors(view.backgroundColor?.getRGBA())
        
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
            
            let text = self.textField.getText()
            if (UIColor.validateHEX(hex: text)) {
                self.view.backgroundColor = UIColor(hex: text)
            }
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
        
    }
    
    // MARK: - Configure seg control
    
    private func configureSegmentedControl() {
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = .orange
        
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
            rgbSlider.updateColors(view.backgroundColor?.getRGBA())
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
