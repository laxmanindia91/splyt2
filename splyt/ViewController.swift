//
//  ViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 9/22/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
import SinchVerification
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ViewController: UIViewController {
 
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewforPhoneno: UIView!
    @IBOutlet weak var viewForNextBtn: UIView!
    
     var verification : Verification!
    var applicationkey = "89789369-0d4a-4bb0-8f42-31e349aa9f6a";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loadivarthe view, typically from a nib.
        
        viewForNextBtn.layer.cornerRadius = 5
        viewForNextBtn.clipsToBounds = true
        viewforPhoneno.layer.cornerRadius = 5
        viewforPhoneno.clipsToBounds = true
         }

    func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        numberTextField.resignFirstResponder()
    }
   
    @IBAction func verifyPhoneNumber(_ sender: UIButton) {
        
        numberTextField.resignFirstResponder()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters : NSDictionary  =
            [
                "phone_num" : "+919466487502",
             ]
        print(parameters)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request("http://localhost:8000/user/validate/", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
                
            case .success(_):
                
                if response.result.value != nil{
                    
                    var dict:NSDictionary = NSDictionary()
                    dict = (response.result.value! as? NSDictionary)!
                    
                    print(dict)
                    
                    
                    
                }
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                break
                
            case .failure(_):
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                
                Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again later.", viewController: self)
                break
                
            }
        }
        
        
        
     /*   let otpView = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNoVerificationViewIdentifier") as! PhoneNoVerificationViewController
        otpView.PhoneNoStr = self.numberTextField.text!
        self.navigationController!.pushViewController(otpView, animated: true)
        
        if numberTextField.text == "" || numberTextField.text == " "{
            Utility.showAlert(title: "Alert", message: "Please Provide Phone number", viewController: self)
        }
        else{
        print(numberTextField.text!)
        verification = SMSVerification("89789369-0d4a-4bb0-8f42-31e349aa9f6a", phoneNumber: numberTextField.text!)
        
        verification.initiate { (initiationResult, error) in
            if initiationResult.success == true {

                //Process the flow and display UI for verification of code
                let otpView = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNoVerificationViewIdentifier") as! PhoneNoVerificationViewController
                otpView.PhoneNoStr = self.numberTextField.text!
                self.navigationController!.pushViewController(otpView, animated: true)

            }
            else {
                print(error!)
                let alertVC = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
             //   UIApplication.shared.keyWindow!.self.present(alertVC, animated: true, completion: nil)
            }
         }
       }*/

    }

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        //LoginViewIdentifier
        let loginView = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewIdentifier") as! LoginViewController
        self.navigationController!.pushViewController(loginView, animated: true)

    }
    
    @IBAction func helpBtnClicked(_ sender: UIButton) {
    }
    
    @IBAction func showKeyBoardBtnClicked(_ sender: UIButton) {
        numberTextField.becomeFirstResponder()
    }
   
}

