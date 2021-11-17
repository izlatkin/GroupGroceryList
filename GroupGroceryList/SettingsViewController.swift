//
//  SettingsViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/16/21.
//

import UIKit

class SettingsViewController: UIViewController {

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
