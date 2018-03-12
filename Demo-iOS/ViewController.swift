//
//  ViewController.swift
//  Demo-iOS
//
//  Created by Luiz on 13.02.18.
//  Copyright © 2018 smoca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Views
    @IBOutlet weak var weightInputField: UITextField!
    @IBOutlet weak var heightInputField: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var bmiOutputLabel: UILabel!
    
    // MARK: Actions
    @IBAction func calculateAction(_ sender: UIButton) {
        
        guard let weight = getIntFrom(weightInputField.text) else {
            return
        }
        
        guard let height = getIntFrom(heightInputField.text) else {
            return
        }
        
        let body = Body(weight: weight, andHeight: height)
        let bmi: Int? = body?.getBmi()
        
        bmiOutputLabel.text = bmi?.description
        bmiLabel.isHidden = false
        bmiOutputLabel.isHidden = false
        
    }
    
    private func getIntFrom(_ input: String?) -> Int? {
        guard let string = input else {
            return nil
        }
        
        return Int(string)
    }

}

