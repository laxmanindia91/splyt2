//
//  ForgetPasswordViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 10/28/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
import SinchVerification

class ForgetPasswordViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var phoneNumbertxtField: UITextField!
  
    var verification : Verification!
    var applicationkey = "89789369-0d4a-4bb0-8f42-31e349aa9f6a";


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func helpBtnClicked(_ sender: UIButton) {
    }
   
    @IBAction func veifyBtnClicked(_ sender: UIButton) {
        if  phoneNumbertxtField.text == "" || phoneNumbertxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter the phone number", viewController: self)
        }
        else{
            
            verification = SMSVerification("+QZJwSUMdUaIM6jFXyqElA==", phoneNumber: phoneNumbertxtField.text!)
            
            verification.initiate { (initiationResult, error) in
                if initiationResult.success == true {
                    
                    //Process the flow and display UI for verification of code
                    let otpView = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNoVerificationViewIdentifier") as! PhoneNoVerificationViewController
                    otpView.PhoneNoStr = self.phoneNumbertxtField.text!
                    self.navigationController!.pushViewController(otpView, animated: true)
                    
                }
                else {
                    let alertVC = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                    //   UIApplication.shared.keyWindow!.self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
}
