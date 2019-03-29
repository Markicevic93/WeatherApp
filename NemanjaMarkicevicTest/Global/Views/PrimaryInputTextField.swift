//
//  PrimaryInputTextField.swift
//  ExpertLeadTest
//
//  Created by Nemanja Markicevic on 12/2/19.
//

import UIKit

class PrimaryInputTextField: UITextField {
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
}
