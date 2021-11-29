//
//  ChangeUsernameViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/22/21.
//

import UIKit
import Parse

class ChangeUsernameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var currentUsernameLabel: UILabel!
    
    @IBOutlet weak var currentUsername: UILabel!
    
    @IBOutlet weak var newUsernameField: UITextField!
    
    @IBOutlet weak var newUsernameLabel: UILabel!
    
    
    @IBOutlet weak var submitButton: UIButton!
    let userinfo = PFObject(className: "UserInfo")
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        userinfo["Username"] = PFUser.current()!
     
        let user = userinfo["Username"] as! PFUser
        currentUsername.text = user.username

        // Do any additional setup after loading the view.
    }
    let defaults = UserDefaults.standard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            self.view.backgroundColor = UIColor.white
            currentUsernameLabel.textColor = UIColor.black
            currentUsername.textColor = UIColor.black
            newUsernameLabel.textColor = UIColor.black
            titleLabel.textColor = UIColor.black
            
        }
        if (modeValue == 1)
        {
            self.view.backgroundColor = UIColor.black
            currentUsernameLabel.textColor = UIColor.white
            currentUsername.textColor = UIColor.white
            newUsernameLabel.textColor = UIColor.white
            titleLabel.textColor = UIColor.white
            
            
        }
    }
    
    @IBAction func ChangeUsername(_ sender: UIButton) {
        let user = userinfo["Username"] as! PFUser
        let newusername = newUsernameField.text
        print (newusername)
        let id = user.objectId
        print (id)
        user.username = newusername
        user.saveInBackground()
       // print (user.username)
        

     
       
       
        

        
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
