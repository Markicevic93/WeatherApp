//
//  LoginService.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 12/2/19.
//

import Foundation

struct LoginService {
    
    static func login(email: String, password: String, completion: @escaping (_ success: ResponseStatus)-> Void) -> URLSessionDataTask? {
        let dataTask = RequestManager.getDataTask(url: RequestEndpoint.login, method: RequestMethod.post, parameters: [RequestKeys.emailKey : email, RequestKeys.passwordKey : password]) { (value) in
            if let response = value {
                let message = response.json[RequestKeys.messageKey] as? String ?? ResponseMessage.defaultError
                
                switch response.statusCode {
                case RequestErrorCode.successArray:
                    completion(.success(message))
                case RequestErrorCode.requestCancelled:
                    completion(.canceled)
                default:
                    completion(.failed(message))
                }
            } else {
                completion(.failed(ResponseMessage.defaultError))
            }
        }
        
        return dataTask
    }
}
