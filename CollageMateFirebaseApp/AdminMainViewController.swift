//
//  AdminMainViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 06/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

import FirebaseDatabase

import FirebaseAuth

class AdminMainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    var refUser:DatabaseReference!
    
    let ref = Database.database().reference(withPath: "users")
    
    @IBOutlet weak var tableView: UITableView!

    
    var userList = [UserModel]()
    
    var unApproveHodList = [UserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refUser = Database.database().reference().child("users")
        
        refUser.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount>0{
                
                self.userList.removeAll()
                
                for users in snapshot.children.allObjects as![DataSnapshot]
                {
                    let userObject =  users.value as? [String: AnyObject]
                  
                    let id = userObject?["uid"]
                    
                    let userName = userObject?["userName"]
                    
                   
                    let  email = userObject?["email"]
                    
                    let password = userObject?["password"]

                    let mobileNo = userObject?["mobileNo"]

                    let typeOfUser = userObject?["typeOfUser"]
                    let approveStatus = userObject?["approveStatus"]
                    
                    
                  
                    let user = UserModel(id: id as! String?, userName: userName as! String?,email: email as! String?, passowrd: password as! String!,mobileNo: mobileNo as! String?,typeOfUser: typeOfUser as! String?,approveStatus: approveStatus as! String?)
                    
                    print(user.id)
                    print(user.userName)
                    print(user.email)
                    print(user.mobileNo)
                    print(user.approveStatus)
                    print(user.typeOfUser)
                    
                   // self.userList.append(user)
                    
                    
             
                    if (user.typeOfUser == "head of the department" && user.approveStatus == "false" )
                    {
                        
                       self.userList.append(user)
                     // self.unApproveHodList.append(user.userName)
                        
                    //self.userList.append((userName as! AnyObject) as! UserModel)
                    }
                        /*
                   else if (user.typeOfUser == "head of the department" && user.approveStatus == "true" )
                    {
                         self.userList.append(user)
                    }
                     */
                    
                    
                    
                    
                    
                  
                    
                    
                }
                
                self.tableView.reloadData()
            }
            
        })
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        
        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signUp")
        
        self.present(signInCont!, animated: true, completion: nil)
    }
    
    
  public  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Not Approved HOD"
    }
    
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return userList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AdminPanelTableViewCell
        
       let user:UserModel
        
        user = userList[indexPath.row]
        
        cell.lableName.text = user.userName
        cell.labelTypeOfUser.text = user.typeOfUser

        //cell.detailTextLabel?.text = user.typeOfUser
        /*
        var unAppHod:UserModel
        
        unAppHod = unApproveHodList[indexPath.row]
        
        cell.lableName.text = unAppHod.userName
        
    */
        
        return cell
        
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        // action one
        let addAction = UITableViewRowAction(style: .default, title: "Approve", handler: { (action, indexPath) in
            print("Add tapped")
        })
        addAction.backgroundColor = UIColor.red
        
        return [addAction]
    }
 */
    
   public  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let user = userList[indexPath.row]
    
    
    let alertController = UIAlertController(title: user.userName, message: "Update Approve Status", preferredStyle:.alert)
    
    let updateAction = UIAlertAction(title: "Approve", style: .default) { (_) in
        
        let id = user.id
        
        let userName = user.userName
        
        let  email = user.email
        let password = user.password
        
        let mobileNo = user.mobileNo
        
        let typeOfUser = user.typeOfUser
        //let approveStatus = alertController.textFields?[0].text
        let approveStatus = "true"
        
        self.updateData(id: id!, userName: userName!, email: email!, password: password!, mobileNo: mobileNo!, typeOfUser: typeOfUser!, approveStatus: approveStatus)
        
    }
    
    let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (_) in
        
        
    }
    
    /*alertController.addTextField { (textField) in
    
    textField.text = user.approveStatus
    }
   */
    alertController.addAction(updateAction)
    alertController.addAction(cancelAction)
    
    
    present(alertController,animated: true,completion: nil)
    
        
   //  let id = user.id
     
     
        
    //let approveStatus = "true"
        
    
   
        
    
    
    
  
    
    }
    
    func updateData(id : String,userName: String,email:String,password:String,mobileNo:String,typeOfUser:String,approveStatus:String)
    {
        let users = [
            "uid":id,
            
            "userName" :userName,
            "email" : email,
            "password" : password,
            "mobileNo" : mobileNo,
            "typeOfUser" : typeOfUser,
            "approveStatus" : approveStatus
        
        ]
        refUser.child(id).setValue(users)
        
    }
 /*
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
 
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath);?.accessoryType = .Checkmark {
        // 1
        guard let cell1 = tableView.cellForRow(at: indexPath) else { return }
        // 2
        let userItem = userList[indexPath.row]
        // 3
        let toggledCompletion = userItem.approveStatus
        
        
        // 4
        
        
    
(cell1, isCompleted: toggledCompletion)
        // 5
        userItem.ref?.updateChildValues([
            "approveStatus": toggledCompletion
            ])
    }
 */
    
    
    
    
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
  }  */

}
