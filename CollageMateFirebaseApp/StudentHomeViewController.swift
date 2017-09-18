//
//  StudentHomeViewController.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 03/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

class StudentHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }

    
    @IBAction func signUpButton(_ sender: Any) {
        
        let signInCont = self.storyboard?.instantiateViewController(withIdentifier: "signUp")
        
        self.present(signInCont!, animated: true, completion: nil)
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
