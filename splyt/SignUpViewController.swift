//
//  SignUpViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 10/24/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var facilityImgView: UIImageView!
    @IBOutlet weak var ormotorImgView: UIImageView!
    @IBOutlet weak var bottleServieImgView: UIImageView!
    @IBOutlet weak var splytUserImgView: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var ownerView: UIView!
    @IBOutlet weak var facilityNameView: UIView!
    @IBOutlet weak var facilityAddressView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var useNameTxtField: UITextField!
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var ownerTxtField: UITextField!
    @IBOutlet weak var facilityNameTxtField: UITextField!
    @IBOutlet weak var facilityAddressTxtField: UITextField!
    @IBOutlet weak var emailTxtFields: UITextField!
    
    //MARK:- Variables
    
    var phoneNumberString:String = String()
    
    var userType:String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
mainScrollView.contentSize.height = emailView.frame.origin.y + emailView.frame.size.height + 20
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
    
    @IBAction func facilityOwnerBtnClicked(_ sender: UIButton) {
        userType = "fo"
        print(userType)
        facilityImgView.image = UIImage(named: "radio-red")
        ormotorImgView.image = UIImage(named: "radio-btn")
        bottleServieImgView.image = UIImage(named: "radio-btn")
        splytUserImgView.image = UIImage(named: "radio-btn")
    }
    
    @IBAction func promotorBtnClicked(_ sender: UIButton) {
        userType = "pr"
        print(userType)
        facilityImgView.image = UIImage(named: "radio-btn")
        ormotorImgView.image = UIImage(named: "radio-red")
        bottleServieImgView.image = UIImage(named: "radio-btn")
        splytUserImgView.image = UIImage(named: "radio-btn")

    }
    
    @IBAction func bottleServiveBtnClicked(_ sender: UIButton) {
        userType = "bsp"
        print(userType)
        facilityImgView.image = UIImage(named: "radio-btn")
        ormotorImgView.image = UIImage(named: "radio-btn")
        bottleServieImgView.image = UIImage(named: "radio-red")
        splytUserImgView.image = UIImage(named: "radio-btn")

    }
    
    @IBAction func splytBtnClicked(_ sender: UIButton) {
        userType = "su"
        print(userType)
        facilityImgView.image = UIImage(named: "radio-btn")
        ormotorImgView.image = UIImage(named: "radio-btn")
        bottleServieImgView.image = UIImage(named: "radio-btn")
        splytUserImgView.image = UIImage(named: "radio-red")

    }
    
    @IBAction func createAccountBtnClicked(_ sender: UIButton) {
        
        if useNameTxtField.text == "" || useNameTxtField.text == " " {
          Utility.showAlert(title: "Alert", message: "Please Enter UserName", viewController: self)
        }
        else if fullNameTxtField.text == "" || fullNameTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter FullName", viewController: self)
        }
        else if passwordTxtField.text == "" || passwordTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter Password", viewController: self)
        }
        else if ownerTxtField.text == "" || ownerTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter Enter Facility Owner", viewController: self)
        }
        else if facilityNameTxtField.text == "" || facilityNameTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter Facility Name", viewController: self)
        }
        else if facilityAddressTxtField.text == "" || facilityAddressTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter Facility Address", viewController: self)
        }
        else if emailTxtFields.text == "" || emailTxtFields.text == " " {
            Utility.showAlert(title: "Alert", message: "Please Enter Email", viewController: self)
        }
        else if Utility.isValidEmail(testStr: emailTxtFields.text!) == false{
            Utility.showAlert(title: "Alert", message: "Please Enter Valid Email", viewController: self)
        }
        else if facilityImgView.image == UIImage(named: "radio-btn") && ormotorImgView.image == UIImage(named: "radio-btn") && bottleServieImgView.image == UIImage(named: "radio-btn") && splytUserImgView.image == UIImage(named: "radio-btn"){
            Utility.showAlert(title: "Alert", message: "Please Select User type", viewController: self)
        }
        else{
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["username": useNameTxtField.text!,
                 "email" : emailTxtFields.text!,
            ]
            print(parameters)
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Alamofire.request("\(GlobalConstants.baseURL)/validateUsernameAndEmail", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                    
                case .success(_):
                    
                    if response.result.value != nil{
                        
                        var dict:NSDictionary = NSDictionary()
                        dict = (response.result.value! as? NSDictionary)!
                        
                        print(dict)
                        
                        if dict.value(forKey: "already_registered")as! Bool == true{
                            Utility.showAlert(title: "Alert", message: "\(dict.value(forKey: "message")!)", viewController: self)
                        }
                        else{
                            self.registerUser()
                        }
                        
                        //SuccesFullRegistrationViewIdentifier
                        
                    }
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    break
                    
                case .failure(_):
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again later.", viewController: self)
                    break
                    
                }
            }
            
      /*     */
        }
    }
        func registerUser(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["username": useNameTxtField.text!,
                 "password" : passwordTxtField.text!,
                 "email" : emailTxtFields.text!,
                 "facility_name" : facilityNameTxtField.text!,
                 "facility_address" : facilityAddressTxtField.text!,
                 "phone" : phoneNumberString,
                 "fullname" : fullNameTxtField.text!,
                 "secret" : "splyt",
                 "device_type" : "I",
                 "device_token" : "asfgretjjukg",
                 "user_type" : userType
                    
            ]
            print(parameters)
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Alamofire.request("\(GlobalConstants.baseURL)/sign_up", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                    
                case .success(_):
                    
                    if response.result.value != nil{
                        
                        var dict:NSDictionary = NSDictionary()
                        dict = (response.result.value! as? NSDictionary)!
                        
                        print(dict)
                        
                        if dict.value(forKey: "error")as! Bool == false{
                            
                            var userInfoDict:NSDictionary = NSDictionary()
                            userInfoDict = dict.value(forKey: "userInfo") as! NSDictionary
                            
                            if userInfoDict.value(forKey: "status") as! Bool == true{
                              //  SuccesFullRegistrationViewIdentifier
                                let successView = self.storyboard!.instantiateViewController(withIdentifier: "SuccesFullRegistrationViewIdentifier") as! SuccesFullRegistrationViewController
                                self.navigationController!.pushViewController(successView, animated: true)

                            }
                            
                        }
                        
                        //SuccesFullRegistrationViewIdentifier
                        
                    }
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    break
                    
                case .failure(_):
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again later.", viewController: self)
                    break
                    
                }
            }
        }
 
    
    
}
