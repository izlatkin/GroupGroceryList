//
//  SettingsViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/16/21.
//

import UIKit

class SettingsViewController: UIViewController {
    bool on = false
   

    @IBOutlet weak var signOut: UIButton!
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var changeProfile: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var changeUsername: UIButton!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    @IBOutlet weak var changePassword: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var changeName: UIButton!
    
    
    @IBOutlet weak var modeSlider: UISwitch!
    
    
    @IBOutlet weak var modeIndicator: UILabel!
    
    @IBOutlet weak var basicUserLabel: UILabel!
    
    @IBOutlet weak var basicPasswordLabel: UILabel!
    
    @IBOutlet weak var basicNameLabel: UILabel!
    
    
    @IBAction func changeProfilePic(_ sender: Any) {
        let picker=UIImagePickerController()
        picker.delegate=self
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
    
    
    
    
    
    @IBAction func modeActivated(_ sender: UISwitch) {
        
        if modeSlider.isOn {
            modeIndicator.text = "Dark Mode Activated"
             on = true
            
        }
        else {
            modeIndicator.text = "Dark Mode Off"
            on = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let on = defaults.bool(forKey: "myBool")
        if bool(on) == true {
            modeslider.on
        }
        else {
            modeSlider.off
        }
        
        if on == true {
            self.view.backgroundColor = UIColor.black
            displayName.textColor = UIColor.white
            usernameLabel.textColor = UIColor.white
            passwordLabel.textColor = UIColor.white
            nameLabel.textColor = UIColor.white
            modeIndicator.textColor = UIColor.white
            basicUserLabel.textColor = UIColor.white
            basicPasswordLabel.textColor = UIColor.white
            basicNameLabel.textColor = UIColor.white
            
        }
        else {
            self.view.backgroundColor = UIColor.white
            displayName.textColor = UIColor.black
            usernameLabel.textColor = UIColor.black
            passwordLabel.textColor = UIColor.black
            nameLabel.textColor = UIColor.white
            modeIndicator.textColor = UIColor.black
            basicUserLabel.textColor = UIColor.black
            basicPasswordLabel.textColor = UIColor.black
            basicNameLabel.textColor = UIColor.black
            
        }
    
        
    
        
    }
    
    @IBAction func LogOut(_ sender: Any) {
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
