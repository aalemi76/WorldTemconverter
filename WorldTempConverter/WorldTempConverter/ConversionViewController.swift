//
//  ConversionViewController.swift
//  WorldTempConverter
//
//  Created by Catalina on 3/21/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var TapGestureRecognizer: UITapGestureRecognizer!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        if hour < 12 {
            view.backgroundColor = .lightGray
            fahrenheitTextField.backgroundColor = .lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
        print("ConversionController loaded its view.")
    }
    
    
    //MARK:- Actions
    
    @IBAction func fahrenheitFieldEditingChanged(){
        if let fahrenheitTemp = fahrenheitTextField.text,
            let number = numberFormatter.number(from: fahrenheitTemp) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(){
        fahrenheitTextField.resignFirstResponder()
        if fahrenheitValue == nil {
            celsiusLabel.text = "???"
        }
    }
    
    //MARK:- Helper Methods:
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalPoint = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalPoint = string.range(of: decimalSeparator)
        let characterSet = NSCharacterSet.letters
        let textSetReplacement = NSCharacterSet(charactersIn: string)
        let replacementContainAlphabet = characterSet.isSuperset(of: textSetReplacement as CharacterSet)
        if replacementContainAlphabet || (existingTextHasDecimalPoint != nil &&
            replacementTextHasDecimalPoint != nil) {
            return false
        } else {
            return true
        }
    }
}
