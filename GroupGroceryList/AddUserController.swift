//
//  AddUserController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

class AddUserController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    //COULD NOT LOOK UP PARSE OBJECTS DIRECTLY in Arrays, USED DICTIONARY OF USERNAMES for tracking which accounts added
    
    var UserList:[PFObject]=[]          //displays search results
    var AddedUserList:[PFObject]=[]     //where users are actually added
    var listname = ""
    var UsersAdded:[String: PFObject]=[:]       //for tracking which users had been added
    let Me = PFUser.current()
    
    
    @IBOutlet weak var TLlistname: UILabel!
    @IBOutlet weak var TVUsers: UITableView!

    
    @IBOutlet weak var TVAddedUsers: UITableView!
    
    @IBOutlet weak var TFSearchText: UITextField!   //made 2 outlets to get this to work
    
    @IBAction func CreateListAction(_ sender: Any) {
        //ToDo: need to implement nessesary checks for successfull goto List
        performSegue(withIdentifier: "ItemSearchSegue", sender: nil)
        
    }
    
    
    @IBAction func TFSearchUsers(_ sender: Any) {
        let str = TFSearchText.text
       
        
        if str?.count ?? 0 >= 1{
            
            let query = PFUser.query()
            query?.whereKey("username", contains: str)
            query?.findObjectsInBackground { (list, Error) in
                if list != nil{
                    self.UserList = list!
                    self.TVUsers.reloadData()
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
        let myusername = Me!["username"] as! String
        AddedUserList.append(PFUser.current()!)
        UsersAdded[myusername] = Me
        
        TVUsers.dataSource = self
        TVUsers.delegate = self
        TLlistname.text = listname
        TVAddedUsers.dataSource = self
        TVAddedUsers.delegate = self
        
        
    //    self.TVUsers.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == TVUsers{
            return self.UserList.count
        }
        else{
            return self.AddedUserList.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == TVUsers{
            print("og tableview")
            let cell = TVUsers.dequeueReusableCell(withIdentifier: "EachUserCell") as! EachUserCell
            
            let username = UserList[indexPath.row]["username"] as! String
            let user = UserList[indexPath.row]
            
            if username == Me!["username"] as! String{
                cell.btnSelectUser.isHidden = true
            }
            else{
                cell.btnSelectUser.isHidden = false
            }
            
            let file=user["ProfilePicture"] as! PFFileObject
            let urlstring=file.url!
            let url=URL(string: urlstring)!
                
            cell.TLUserName.text = username
            cell.ivProfilePic.af_setImage(withURL: url)
            
            cell.configure(with: user )
            cell.delegate = self
            return cell
        }
        else{
            print("other tv")
    
            let cell = TVAddedUsers.dequeueReusableCell(withIdentifier: "EachAddedUserCell") as! EachAddedUserCell
            var username = AddedUserList[indexPath.row]["username"] as! String
            let user = AddedUserList[indexPath.row]
            let file=user["ProfilePicture"] as! PFFileObject
            let urlstring=file.url!
            let url=URL(string: urlstring)!
            
            if username == Me!["username"] as! String{
                username.append(" (Me)")
                cell.TLusername.text = username
            }
            else{
                cell.TLusername.text = username
            }
                
            cell.ivProfilePic.af_setImage(withURL: url)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //not needed
    }
    

}

extension AddUserController: UserCellDelegate{
    func TappedCellbtn(with user: PFObject) {
        
        let name = user["username"] as! String
        
        if UsersAdded[name] == nil{
            UsersAdded[name] = user
            AddedUserList.append(user)
            print("added")
        }
        else{
            print("removing")
            UsersAdded[name] = nil
            var index = 0
            for person in AddedUserList{
                if person["username"] as! String == name{
                    AddedUserList.remove(at: index)
                    break
                }
                index+=1
            }
            
            //let index = AddedUserList.firstIndex(of: user) ?? 0     wouldn't work-needed username over the user
            //AddedUserList.remove(at: index)
            
        }
        
        self.TVAddedUsers.reloadData()
        
    }
}
