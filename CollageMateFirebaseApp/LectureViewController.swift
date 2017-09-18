//
//  LectureViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 03/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

class LectureViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var lectureDetailTableView: UITableView!
    
    var timeDetail = ["8AM to 9AM     Physics","9AM to 10AM    Chemistry","10AM to 11AM    Maths","11AM to 12AM    Maths"]
    
    
    
      let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectureDetailTableView.dataSource=self
        lectureDetailTableView.delegate=self
        
        self.lectureDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)


        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        
        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signOut")
        
        self.present(signInCont!, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.timeDetail.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell:UITableViewCell = self.lectureDetailTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
       
        
        let timeDetail = self.timeDetail[indexPath.row] //2.
       
        cell.textLabel?.text = timeDetail
        
        
        
        
        

       return cell
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
