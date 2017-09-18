//
//  IssueBookViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 03/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

class IssueBookViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var bookName: [String] = ["Appied Physics by A.P.Gambhir", "Appied MathsIII by Kumbhojkar", "Appied MathsIV by Kumbhojkar", "Analysis Of Algoritham by Sahani", " Operating System by Galvin ", "Theory Of Computer Science by Kamal Shah"]
    
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signUp")
        
        self.present(signInCont!, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.bookName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
       
        
        // action one
        let addAction = UITableViewRowAction(style: .default, title: "Issue", handler: { (action, indexPath) in
            print("Add tapped")
        })
        addAction.backgroundColor = UIColor.red
        
        return [addAction]
    }
    
    
    override func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
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
