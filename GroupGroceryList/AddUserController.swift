//
//  AddUserController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

class AddUserController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var UserList:[PFObject]=[]
    
    
    @IBOutlet weak var TVUsers: UITableView!

    @IBOutlet weak var TFSearchText: UITextField!   //made 2 outlets to get this to work
    
    @IBAction func TFSearchUsers(_ sender: Any) {
        var str = TFSearchText.text
        
        if str?.count ?? 0 >= 1{
            
            let query = PFUser.query()
            query?.whereKey("username", contains: str)
            query?.findObjectsInBackground { list, Error in
                if list != nil{
                    self.UserList = list!
                    self.TVUsers.reloadData()
                    //print("got data")
                }
            }
        
        }
        else{
            self.UserList.removeAll()
            self.TVUsers.reloadData()
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TVUsers.dataSource = self
        TVUsers.delegate = self
    //    self.TVUsers.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.UserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TVUsers.dequeueReusableCell(withIdentifier: "EachUserCell") as! EachUserCell
        
        let username = UserList[indexPath.row]["username"] as! String

        
        let user = UserList[indexPath.row]
        
        cell.TLUserName.text = username
        
        let file=user["ProfilePicture"] as! PFFileObject
        let urlstring=file.url!
        let url=URL(string: urlstring)!
    
        cell.ivProfilePic.af_setImage(withURL: url)
        return cell
    }
    

}
