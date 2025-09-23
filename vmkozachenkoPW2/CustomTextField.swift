import UIKit

final class CustomTextField : UIView {
    
    // MARK: - Constants
    
    enum Constants {
        static let heightOfAllField : Double = 30
        
        static let buttonTitle = "+"
        static let buttonWidth : Double = 50
    }
    
    // MARK: - Fields
    
    var buttonPressed : (() -> Void)?
    
    let textField = UITextField()
    let sendButton = UIButton(type: .system)
    
    let width : Double
    
    // MARK: - Inits
    
    init(width: Double, placeholder: String) {
        self.width = width >= Constants.buttonWidth ? width : Constants.buttonWidth
        super.init(frame: .zero)
        
        sendButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchDown)
        sendButton.setTitle(Constants.buttonTitle, for: .normal)
        
        textField.placeholder = placeholder
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
        
        sendButton.backgroundColor = .orange
        
        for view in [textField, sendButton] {
            view.translatesAutoresizingMaskIntoConstraints = false;
        }
        
        self.addSubview(textField)
        self.addSubview(sendButton)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.heightOfAllField),
            self.widthAnchor.constraint(equalToConstant: width),
            
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.heightOfAllField),
            textField.widthAnchor.constraint(equalToConstant: width - Constants.buttonWidth),
            
            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            sendButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: Constants.heightOfAllField)
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
