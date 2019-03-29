//
//  RequestConstants.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 12/2/19.
//

import Foundation

struct RequestErrorCode {
    static let requestCancelled = -999
    static let successArray = 200..<300
}

struct RequestMethod {
    static let post = "POST"
}

struct RequestEndpoint {
    
    static let login = "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate"
}

struct RequestKeys {
    
    static let emailKey     = "email"
    static let passwordKey  = "password"
    static let messageKey   = "message"
    static let requestCancelledKey = "cancelled"
}

struct ResponseMessage {
    
    static let defaultError = "Not a valid response"
}
