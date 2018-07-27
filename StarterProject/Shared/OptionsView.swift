//
//  OptionsView.swift
//  iOS
//
//  Created by student on 7/26/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import Foundation
import UIKit

protocol SendScenarioDelegate: class {
    func sendScenario(scenario: Int)
}

class OptionsView: UIView {
    
    @IBOutlet weak var scenario1: UIButton!
    
    @IBOutlet weak var scenario2: UIButton!
    
    @IBOutlet weak var custom: UIButton!
    
    weak var scenarioDelegate: SendScenarioDelegate?
    
    @IBAction func scenario1Pressed(_ sender: UIButton) {
        self.scenarioDelegate?.sendScenario(scenario: 1)
    }
    
    @IBAction func scenario2Pressed(_ sender: UIButton) {
        
        self.scenarioDelegate?.sendScenario(scenario: 2)
        
    }
    
}
