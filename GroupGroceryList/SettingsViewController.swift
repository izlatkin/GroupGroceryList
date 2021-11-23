//
//  SettingsViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/16/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let modes = [0,1]
    
   
  
    @IBOutlet weak var SignOut: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
   
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var changeUsername: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeName: UIButton!
   

    @IBOutlet weak var changePicture: UIButton!
    
    @IBOutlet weak var viewMode: UISegmentedControl!
    @IBOutlet weak var basicUserLabel: UILabel!
    @IBOutlet weak var basicPasswordLabel: UILabel!
    @IBOutlet weak var basicNameLabel: UILabel!
    
    @IBOutlet weak var clearLabel: UILabel!
    var om_var = false
   
    
    @IBAction func changeProfilePic(_ sender: Any) {
        let picker=UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing=true
        print("clicking")
    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modeValue = defaults.double(forKey: "myInt")
      
               viewMode.selectedSegmentIndex = Int(modeValue)
        
        
        let userinfo = PFObject(className: "UserInfo")
        userinfo["Username"] = PFUser.current()!
        userinfo["Password"] = PFUser.current()!
        
     
        let user = userinfo["Username"] as! PFUser
        usernameLabel.text = user.username
       // let user2 = userinfo["Password"] as! PFUser
        //passwordLabel.text = user2.password
        let imageFile = user["ProfilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        
        profileImage.af_setImage(withURL: url!)
        
               if (modeValue == 0)
               {
                   self.view.backgroundColor = UIColor.white
                   titleLabel.textColor = UIColor.black
                   displayName.textColor = UIColor.black
                   usernameLabel.textColor = UIColor.black
                   passwordLabel.textColor = UIColor.black
                   nameLabel.textColor = UIColor.black
                   basicUserLabel.textColor = UIColor.black
                   basicPasswordLabel.textColor = UIColor.black
                   basicNameLabel.textColor = UIColor.black
                   
                   
                   
               }
               if (modeValue == 1)
               {
                   self.view.backgroundColor = UIColor.black
                   titleLabel.textColor = UIColor.white
                   displayName.textColor = UIColor.white
                   usernameLabel.textColor = UIColor.white
                   passwordLabel.textColor = UIColor.white
                   nameLabel.textColor = UIColor.white
                   basicUserLabel.textColor = UIColor.white
                   basicPasswordLabel.textColor = UIColor.white
                   basicNameLabel.textColor = UIColor.white
                 
               }
    }
    let defaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = defaults.string(forKey: "myString")
        displayName.text = name
        nameLabel.text = name
        
        
               
    }

      
      
    
        
    
    @IBAction func ColorChanger(_ sender: UISegmentedControl) {
        let modevalue = modes[viewMode.selectedSegmentIndex]
                clearLabel.text = "\(modevalue)"
                defaults.set(clearLabel.text, forKey: "myInt")
    
                if (modevalue == 0)
                {
                    self.view.backgroundColor = UIColor.white
                    titleLabel.textColor = UIColor.black
                    displayName.textColor = UIColor.black
                    usernameLabel.textColor = UIColor.black
                    passwordLabel.textColor = UIColor.black
                    nameLabel.textColor = UIColor.black
                    basicUserLabel.textColor = UIColor.black
                    basicPasswordLabel.textColor = UIColor.black
                    basicNameLabel.textColor = UIColor.black
                    
                }
                if (modevalue == 1)
                {
                    self.view.backgroundColor = UIColor.black
                    titleLabel.textColor = UIColor.white
                    displayName.textColor = UIColor.white
                    usernameLabel.textColor = UIColor.white
                    passwordLabel.textColor = UIColor.white
                    nameLabel.textColor = UIColor.white
                    basicUserLabel.textColor = UIColor.white
                    basicPasswordLabel.textColor = UIColor.white
                    basicNameLabel.textColor = UIColor.white
                    
                }
                defaults.synchronize()

    }
    
    

    
    @IBAction func LogOff(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
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
