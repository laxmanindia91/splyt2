//
//  PhoneNoVerificationViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 10/19/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
import SinchVerification

class PhoneNoVerificationViewController: UIViewController, UITextFieldDelegate {

    //MARK:- Outlets
    @IBOutlet weak var viewForPhoneNumber: UIView!
    
    @IBOutlet weak var textFieldForPhoneNumber: UITextField!
    
    @IBOutlet weak var fistTxtFieldForOtp: UITextField!
    @IBOutlet weak var secondTxtFieldForOtp: UITextField!
    @IBOutlet weak var thirdTxtFieldForOtp: UITextField!
    
    @IBOutlet weak var fourth: UITextField!
    
    
    
    //MARK:- Variables
    var verification : Verification!
    var applicationkey = "89789369-0d4a-4bb0-8f42-31e349aa9f6a";

    var PhoneNoStr:String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldForPhoneNumber.text = PhoneNoStr
        
        // Do any additional setup after loading the view.
        fistTxtFieldForOtp.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        secondTxtFieldForOtp.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        thirdTxtFieldForOtp.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        fistTxtFieldForOtp.becomeFirstResponder()
    }
    
    func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        
        if text?.utf16.count == 1{
            
            switch textField {
            case fistTxtFieldForOtp:
                secondTxtFieldForOtp.becomeFirstResponder()
                
            case secondTxtFieldForOtp:
                thirdTxtFieldForOtp.becomeFirstResponder()
                
            case thirdTxtFieldForOtp:
                fourth.becomeFirstResponder()
                
            case fourth:
                fourth.resignFirstResponder()
                
            default:
                break
            }
            
        }
        
    }

    @IBAction func verifyBtnClicked(_ sender: UIButton) {
        if fistTxtFieldForOtp.text == "" || fistTxtFieldForOtp.text == " " || secondTxtFieldForOtp.text == "" || secondTxtFieldForOtp.text == " " || thirdTxtFieldForOtp.text == "" || thirdTxtFieldForOtp.text == " " || fourth.text == "" || fourth.text == " "{
            Utility.showAlert(title: "Alert", message: "Please fill the OTP Correctly.", viewController: self)
        }
        else{
            var otpString:String = String()
            otpString = "\(fistTxtFieldForOtp.text!)\(secondTxtFieldForOtp.text!)\(thirdTxtFieldForOtp.text!)\(fourth.text!)"
            print(otpString)

            verification!.verify(
                otpString, completion:
                { (success:Bool, error:Error?) -> Void in
                    if (success) {
                        print("Success")
                    } else {
                        print(error!.localizedDescription)
                    }
            });
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let loginView = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewIdentifier") as! LoginViewController
        self.navigationController!.pushViewController(loginView, animated: true)

    }
    
    @IBAction func helpBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func editPhoneNumberBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)

    }
}
