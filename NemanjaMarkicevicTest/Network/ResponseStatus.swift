//
//  ResponseStatus.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 13/2/19.
//

import Foundation

// Improve reponse status enum if needed
enum ResponseStatus {

    case success(String) // message
    case canceled
    case failed(String) // message
}
