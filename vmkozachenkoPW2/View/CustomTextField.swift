import UIKit

final class CustomTextField : UIView {
    
    // MARK: - Constants
    
    enum Constants {
        static let buttonTitle = "+"
        static let buttonWidth : Double = 50
    }
    
    // MARK: - Fields
    
    var buttonPressed : (() -> Void)?
    
    let textField = UITextField()
    let sendButton = UIButton(type: .system)
    
    // MARK: - Inits
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        sendButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchDown)
        sendButton.setTitle(Constants.buttonTitle, for: .normal)
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        textField.isUserInteractionEnabled = true
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        textField.backgroundColor = .white
        textField.textColor = .black
        
        sendButton.backgroundColor = .orange
        sendButton.setTitleColor(.white, for: .normal)
        
        for view in [textField, sendButton] {
            view.translatesAutoresizingMaskIntoConstraints = false;
        }
        
        self.addSubview(textField)
        self.addSubview(sendButton)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sendButton.topAnchor.constraint(equalTo: self.topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
    // MARK: - Get text
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    // MARK: - Button was pressed
    
    @objc
    private func buttonWasPressed() {
        buttonPressed?()
    }
}
