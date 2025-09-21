import UIKit


final class CustomSlider : UIView {
    
    // MARK: - Constants
    
    enum Constants {
        static let titleTop : Double = 10
        static let titleLeading : Double = 20
        
        static let sliderTop : Double = 10
        static let sliderBottom : Double = -10
        static let sliderLeading : Double = 20
    }
    
    var ValueChanged : ((Double) -> Void)?
    let slider = UISlider()
    let title = UILabel()
    
    // MARK: - Initialisers
    
    init(title: String, minValue: Double, maxValue: Double) {
        super.init(frame: .zero)
        
        // set title and slider settings
        self.title.text = title
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for view in [title, slider] {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.titleTop),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.titleLeading),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.sliderTop),
            slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        ValueChanged?(Double(slider.value))
    }
}
