//
//  HomeViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func btnCreateList(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateListSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
