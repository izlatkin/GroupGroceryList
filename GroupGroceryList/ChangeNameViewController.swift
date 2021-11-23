//
//  ChangeNameViewController.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/22/21.
//

import UIKit
import Parse

class ChangeNameViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var currentNameLabel: UILabel!
    
    @IBOutlet weak var currentName: UILabel!
    
    @IBOutlet weak var newNameLabel: UILabel!
    
    
    @IBOutlet weak var newNameField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
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
            self.view.backgroundColor = UIColor.white
            currentNameLabel.textColor = UIColor.black
            titleLabel.textColor = UIColor.black
            currentName.textColor = UIColor.black
            newNameLabel.textColor = UIColor.black
            
            
        }
        if (modeValue == 1)
        {
            self.view.backgroundColor = UIColor.black
            currentNameLabel.textColor = UIColor.white
            titleLabel.textColor = UIColor.white
            currentName.textColor = UIColor.white
            newNameLabel.textColor = UIColor.white
        }
        

     
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
