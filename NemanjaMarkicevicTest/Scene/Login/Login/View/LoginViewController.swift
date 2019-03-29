import UIKit

class LoginViewController: UIViewController {

    // MARK: - @IBOutlet's
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Properties
    
    var presenter: LoginPresenterInput!
    var state: LoginState = .initial
    
    var interactionEnabled: Bool = false {
        didSet {
            loginButton.backgroundColor = interactionEnabled ? UIColor.blue : UIColor.blue.withAlphaComponent(0.6)
            loginButton.isEnabled = interactionEnabled
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenter(view: self)
        
        setupView()
    }
    
    // MARK: - IBAction's
    
    @IBAction func loginTapped(_ sender: UIButton) {
        switch state {
        case .initial, .loginFailed(_):
            login()
        case .loginStarted:
            cancelLoginRequest()
        }
    }
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        errorLabel.textColor = UIColor.red
        emailTextField.borderColor = InputValidationColors.initialColor
        passwordTextField.borderColor = InputValidationColors.initialColor
        
        loginActivityIndicator.stopAnimating()
        interactionEnabled = false
        
        setController(state: .initial)
    }
    
    fileprivate func login() {
        setController(state: .loginStarted)
        
        
        presenter.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    fileprivate func cancelLoginRequest() {
        setController(state: .initial)
        
        presenter.cancelLoginRequest()
    }
    
    fileprivate func validateInputFields() {
        if (emailTextField.text ?? "").contains("@") && !(passwordTextField.text ?? "").isEmpty {
            interactionEnabled = true
        } else {
            interactionEnabled = false
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text ?? ""
        switch textField {
        case emailTextField:
            if text.isEmpty {
                textField.borderColor = InputValidationColors.initialColor
            } else if !text.contains("@") {
                textField.borderColor = InputValidationColors.invalidColor
            } else {
                textField.borderColor = InputValidationColors.validColor
            }
        case passwordTextField:
            if text.isEmpty {
                textField.borderColor = InputValidationColors.initialColor
            } else {
                textField.borderColor = InputValidationColors.validColor
            }
        default:
            break
        }
        
        switch state {
        case .initial, .loginFailed(_):
            validateInputFields()
        default:
            break
        }
    }
}

extension LoginViewController: LoginViewInput {
    
    // MARK: - LoginViewContract
    
    func loginFailedWith(error: String) {
        validateInputFields()
        setController(state: .loginFailed(error))
    }
    
    func loginCancelled() {
        validateInputFields()
        setController(state: .initial)
    }
    
    func loginSuccess(message: String) {
        setController(state: .initial)
    
        if let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
            vc.message = message
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

