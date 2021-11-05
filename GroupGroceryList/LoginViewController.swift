//
//  LoginViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/4/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var TLUsername: UITextField!
    
    @IBOutlet weak var TLPassword: UITextField!
    
    
    
    @IBAction func btnSignup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
       
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let Username=TLUsername.text!
        let Password=TLPassword.text!
        
        PFUser.logInWithUsername(inBackground: Username, password: Password) { user, error in
            if user != nil{
                self.performSegue(withIdentifier: "LoginSuccessSegue", sender: nil)
            }
            else{
                print("Error signing in")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
