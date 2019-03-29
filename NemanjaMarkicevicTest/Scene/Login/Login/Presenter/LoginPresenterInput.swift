import Foundation

protocol LoginPresenterInput: class {
    
    func login(email: String, password: String)
    func cancelLoginRequest()
}
