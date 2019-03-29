//
//  LoginViewController+State.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 12/2/19.
//

import UIKit

enum LoginState {
    case initial
    case loginStarted
    case loginFailed(String) // errorMessage
}

extension LoginViewController {
    
    func setController(state: LoginState) {
        self.state = state
        
        switch state {
        case .initial:
            errorLabel.text = ""
            loginButton.setTitle("Login", for: .normal)
            loginActivityIndicator.stopAnimating()
        case .loginStarted:
            errorLabel.text = ""
            loginButton.setTitle("Cancel", for: .normal)
            loginActivityIndicator.startAnimating()
        case .loginFailed(let error):
            errorLabel.text = error
            loginButton.setTitle("Try again", for: .normal)
            loginActivityIndicator.stopAnimating()
        }
    }
}
