//
//  RequestManager.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 12/2/19.
//

import Foundation

struct RequestManager {
    
    static func getDataTask(url: String, method: String, parameters: [String : String], completion: @escaping ((statusCode: Int, json: [String : Any])?)-> Void) -> URLSessionDataTask? {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let url = URL(string: url) else {
            completion(nil)
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 30
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data else {
                if let code = (error as NSError?)?.code, let message = error?.localizedDescription, message == RequestKeys.requestCancelledKey { // Cancelled by user
                    completion((code , [RequestKeys.messageKey : RequestKeys.requestCancelledKey]))
                } else {
                    completion(nil)
                }
                return
            }
            
            do {
                let json: [String : Any] = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as? [String : Any] ?? [:]
                
                completion((httpResponse.statusCode, json))
            } catch {
                completion(nil)
            }
            
        }
        
        return dataTask
    }
}
