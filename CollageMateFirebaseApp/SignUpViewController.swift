//
//  SignUpViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 01/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import Foundation


import Firebase
import FirebaseAuth
import FirebaseStorage

import FirebaseDatabase
import UIKit

class SignUpViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var typeOfUsersTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
   
    let pickerOption = ["student","teacher","admin","head of the department"]
 
    var userStorage:StorageReference!
    var ref:DatabaseReference!
    var typeOfUser = ""
    var approveStatus = ""
    
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        guard userNameTextField.text != " " && typeOfUsersTextField.text != " " && emailTextField.text != " " && passwordTextField.text != " "  && mobileNoTextField.text != " " && confirmPasswordTextField.text != ""
        else {return}
        
        if passwordTextField.text == confirmPasswordTextField.text
        {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if let error = error
                {
                    print(error.localizedDescription)
                }
                else
                {
                    self.typeOfUser = self.typeOfUsersTextField.text!
                    
                    if(self.typeOfUser == "admin" )
                    {
                        self.approveStatus = "true"
                    }
                    else
                    {
                        self.approveStatus = "false"
                    }
                    
                    

                     let userInfo : [String : String] = ["uid" : (user!.uid as AnyObject) as! String,
                                                            "userName": self.userNameTextField.text!,
                                                            "email": self.emailTextField.text!,
                                                            "password": self.passwordTextField.text!,
                                                            "mobileNo": self.mobileNoTextField.text!,
                                                            "typeOfUser":self.typeOfUsersTextField.text!,
                                                            "approveStatus" : self.approveStatus]
                    
                    self.ref.child("users").child(user!.uid).setValue(userInfo)
                    
                    print("------------------Data saved")
                    
                    let alert = UIAlertController(title: "Success", message: "User Registered Successfuly !!! ( Username - \(self.userNameTextField.text!))", preferredStyle: .alert)
                    
                     print("------------------Success")
                    
                    let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signIn")
                        
                        self.present(signInCont!, animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                   print("------------------Success")
                }
                
            })
            
            
            
        }
        else{
            print("Password does not matched !!!")
            
            let alert2 = UIAlertController(title: "Error", message: "Password Missmatch !!!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert2, animated: true, completion: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        passwordTextField.isSecureTextEntry=true
        confirmPasswordTextField.isSecureTextEntry=true
        
        pickerView.delegate=self
        
        typeOfUsersTextField?.inputView = pickerView
        
        let storage = Storage.storage().reference(forURL: "gs://collegemate-404ec.appspot.com")
        
        userStorage = storage.child("users")
        
        ref = Database.database().reference()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func loginPageButton(_ sender: Any)
    {
        let signInCont = storyboard?.instantiateViewController(withIdentifier: "signIn")
        
        self.present(signInCont!, animated: true, completion: nil)
        
//        self.present(SignInViewController(), animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
      return   pickerOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        typeOfUsersTextField.text = pickerOption[row]
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
