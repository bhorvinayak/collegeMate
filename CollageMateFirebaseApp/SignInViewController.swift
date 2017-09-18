//
//  SignInViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 03/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passowrdTextField: UITextField!
    
    var userType = ""
    var approvedStatus = ""
    //var  dbRef : DatabaseReference!
    
   // var collegeRef : DatabaseReference
    
    
    /*init()
    {
        self.dbRef = Database.database().reference()
        self.collegeRef=self.dbRef.child("users")
        
        
    }
   */
    
    
    
    
override func viewDidLoad() {
        super.viewDidLoad()
    passowrdTextField.isSecureTextEntry=true
    

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createNewAccountButton(_ sender: Any) {
        
        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signUp")
        
        self.present(signInCont!, animated: true, completion: nil)
    }
    @IBAction func signInButton(_ sender: Any) {
        
        guard usernameTextField.text != "" && passowrdTextField.text != "" else
        {return}
        
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passowrdTextField.text!, completion: { (user, error) in
            
            if let error = error
            {
                print(error.localizedDescription)
                
                let alert = UIAlertController(title: "Invalid User or Password", message: "Check Your Username or Password !!!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            
            if user != nil
            {
                self.usernameTextField.text = ""
                self.passowrdTextField.text = ""
                let uid = user?.uid
                let email = user?.email

                print("------------------userid::\(uid!)")
                
                print("------------------useremail::\(email!)")
                

                let ref = Database.database().reference()
                
                ref.child("users").queryOrderedByKey().observeSingleEvent(of: DataEventType.value, with: {(snapshot)
                    
                    in
                    
                    var users = [String : AnyObject]()
                    
                    if(snapshot.exists())
                    {
                        
                        users = snapshot.value as! [String : AnyObject]
                        print("users ::: \(users)")
                        
                    }
                    
                    for (_, value) in users
                    {
                        
                        
                        if let uid = value["uid"] as? String
                        {
                            if uid == Auth.auth().currentUser?.uid
                            {
                                self.userType = (value["typeOfUser"] as? String)!
                                print("typeOfUser ::: \(String(describing: self.userType))")
                                
                                self.approvedStatus = (value["approveStatus"] as? String)!
                                print("typeOfUser ::: \(String(describing: self.approvedStatus))")
                            }
                        }
                    }
                    
                    
                })
                print("------------------login Success")
                
                let alert = UIAlertController(title: "Success", message: "User Login Successfuly !!! ( Username - \(self.usernameTextField.text!))", preferredStyle: .alert)
                
                print("------------------Success")
                
                let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    
                    if(self.userType == "teacher" && self.approvedStatus == "true")
                    {
                        let teacherCont = self.storyboard?.instantiateViewController(withIdentifier: "teacher")
                        
                        self.present(teacherCont!, animated: true, completion: nil)

                    }
                    
                    else if(self.userType == "admin" && self.approvedStatus == "true")
                    {
                        let adminCont = self.storyboard?.instantiateViewController(withIdentifier: "admin")
                        
                        self.present(adminCont!, animated: true, completion: nil)
                    }
                        
                    else if(self.userType == "student" && self.approvedStatus == "true")
                    {
                        let studentCont = self.storyboard?.instantiateViewController(withIdentifier: "student")
                        
                        self.present(studentCont!, animated: true, completion: nil)
                    }

                    else if(self.userType == "head of the department" && self.approvedStatus == "true")
                    {
                        let hodCont = self.storyboard?.instantiateViewController(withIdentifier: "hod")
                        
                        self.present(hodCont!, animated: true, completion: nil)
                    }

                    else
                    {
                        let alert = UIAlertController(title: "Wait", message: "You not approved user. Wait for admin approvel !!!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
                print("------------------Success")


                         }
 
        })
        
        

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
