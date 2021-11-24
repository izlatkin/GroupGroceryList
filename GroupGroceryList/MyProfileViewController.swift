//
//  MyProfileViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/8/21.
//

import UIKit
import Parse

class MyProfileViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    @IBOutlet weak var newLabel: UILabel!
    
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var groupTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    let modeValue = defaults.double (forKey: "myInt")
    if (modeValue == 0)
    {
        self.view.backgroundColor = UIColor.white
        groupLabel.textColor = UIColor.black
        self.groupTV.backgroundColor = UIColor.white
        newLabel.textColor = UIColor.black
        displayNameLabel.textColor = UIColor.black
       
       
     
    }
    if (modeValue == 1)
    {
        self.view.backgroundColor = UIColor.black
        groupLabel.textColor = UIColor.white
        self.groupTV.backgroundColor = UIColor.black
        newLabel.textColor = UIColor.white
        displayNameLabel.textColor = UIColor.white
       
        
      

        
    }
    self.groupTV.reloadData()
        let userinfo = PFObject(className: "UserInfo")
        userinfo["Username"] = PFUser.current()!
        
        let user = userinfo["Username"] as! PFUser
        
        
        let imageFile = user["ProfilePicture"] as! PFFileObject
      
       
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        
        
        profilePicture.af_setImage(withURL: url!)
        let name = defaults.string(forKey: "myString")
        displayNameLabel.text = name
        
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
