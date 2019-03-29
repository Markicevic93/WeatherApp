import Foundation

protocol LoginViewInput: class {

    func loginSuccess(message: String)
    func loginFailedWith(error: String)
    func loginCancelled()
}
