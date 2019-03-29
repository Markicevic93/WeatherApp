import Foundation

class LoginPresenter: LoginPresenterInput {
    
    weak var view: LoginViewInput!
    var dataTask: URLSessionDataTask?
    
    init(view: LoginViewInput) {
        self.view = view
    }
    
    func login(email: String, password: String) {
        dataTask = LoginService.login(email: email, password: password) { [weak self] (response) in
            self?.dataTask = nil
            
            DispatchQueue.main.async {
                switch response {
                case .success(let message):
                    self?.view.loginSuccess(message: message)
                case .canceled:
                    self?.view.loginCancelled()
                case .failed(let message):
                    self?.view.loginFailedWith(error: message)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    func cancelLoginRequest() {
        dataTask?.cancel()
    }
}
