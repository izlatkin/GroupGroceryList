//
//  CreateListViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/6/21.
//

import UIKit

class CreateListViewController: UIViewController {

    
    @IBOutlet weak var btnSubmitListName: UIButton!
    
    
    @IBAction func btnSubmitListName(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(TFListName.text , forKey: "currentList")
    
        self.performSegue(withIdentifier: "AddUsersToListSegue", sender: nil)
    }
    
    @IBOutlet weak var TFListName: UITextField!
    
 
    @IBAction func TFListNameListener(_ sender: Any) {
        print("running")
        let textcount = TFListName.text?.count ?? 0
        
        if textcount > 0 {
            btnSubmitListName.isHidden = false
        }
        else{
            btnSubmitListName.isHidden = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSubmitListName.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddUserController{
            let VC = segue.destination as? AddUserController
            VC?.listname = TFListName.text!
        }
    }
   

}
