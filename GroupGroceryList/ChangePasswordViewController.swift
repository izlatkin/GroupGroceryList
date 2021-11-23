//
//  ChangePasswordViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/22/21.
//

import UIKit
import Parse

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newPasswordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let defaults = UserDefaults.standard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let modeValue = defaults.double(forKey: "myInt")
        if (modeValue == 0)
        {
            oldPasswordLabel.textColor = UIColor.black
            self.view.backgroundColor = UIColor.white
            newPasswordLabel.textColor = UIColor.black
            titleLabel.textColor = UIColor.black
        }
        if (modeValue == 1)
        {
            oldPasswordLabel.textColor = UIColor.white
            self.view.backgroundColor = UIColor.black
            newPasswordLabel.textColor = UIColor.white
            titleLabel.textColor = UIColor.white
        }
        

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
