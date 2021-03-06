//
//  AddUserController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

//observation-to get an objectid in a list with for loop, it has a built in dot operator .objectid, trying to index in like ["username"] will give nil

import UIKit
import Parse

class AddUserController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    //COULD NOT LOOK UP PARSE OBJECTS DIRECTLY in Arrays, USED DICTIONARY OF USERNAMES for tracking which accounts added
    let defaults = UserDefaults.standard

    
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
        let NewList = PFObject(className: "ShoppingList")
        NewList["UserList"] = AddedUserList
        NewList["ListName"] = listname
        NewList["CreatorName"] = PFUser.current()?["username"]
        NewList.saveInBackground { success, Error in
            if success{
             
                //send notifications if success,then segue
                for person in self.AddedUserList{
                    if person["username"] as! String != self.Me!["username"] as! String{
                        let notification = PFObject(className: "AddedToListNotification")
                        notification["ReceiverHasRead"] = false
                        notification["SenderName"] = PFUser.current()?["username"]
                        notification["SenderProfilePic"] = PFUser.current()?["ProfilePicture"]
                        notification["ReceiverID"] =  person.objectId!
                        notification.saveEventually()
                    }
                }
                self.performSegue(withIdentifier: "ItemSearchSegue", sender: nil)
            }
            else{
                print("failed to save new list")
            }
            
        }
        
        
        
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
        //    print("og tableview")
            let cell = TVUsers.dequeueReusableCell(withIdentifier: "EachUserCell") as! EachUserCell
          
            let username = UserList[indexPath.row]["username"] as! String
            let user = UserList[indexPath.row]
            
            if UsersAdded[username] == nil{
                cell.btnSelectUser.setTitle("Add to List", for: .normal)
                cell.btnSelectUser.setTitleColor(UIColor.systemBlue, for: .normal)
              
            }
            else{
                cell.btnSelectUser.setTitle("Remove", for: .normal)
                cell.btnSelectUser.setTitleColor(UIColor.red, for: .normal)
                
            }
            
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
            let modeValue = defaults.double (forKey: "myInt")
            if (modeValue == 0)
            {
                cell.contentView.backgroundColor = UIColor.white
                cell.TLUserName.textColor = UIColor.black
                
            }
            if (modeValue == 1)
            {
                cell.contentView.backgroundColor = UIColor.black
                cell.TLUserName.textColor = UIColor.white
               
            }
           
            return cell
        }
        else{
      //      print("other tv")
    
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
            let modeValue = defaults.double (forKey: "myInt")
            if (modeValue == 0)
            {
                cell.contentView.backgroundColor = UIColor.white
                cell.TLusername.textColor = UIColor.black
                
            }
            if (modeValue == 1)
            {
                cell.contentView.backgroundColor = UIColor.black
                cell.TLusername.textColor = UIColor.white
               
            }
            
            return cell
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            self.view.backgroundColor = UIColor.white
            TLlistname.textColor = UIColor.black
            self.TVUsers.backgroundColor = UIColor.white
            self.TVAddedUsers.backgroundColor = UIColor.white
           
         
        }
        if (modeValue == 1)
        {
            self.view.backgroundColor = UIColor.black
            
            self.TVUsers.backgroundColor = UIColor.black
            self.TVAddedUsers.backgroundColor = UIColor.black
            TLlistname.textColor = UIColor.white
          
            
          

            
        }
        self.TVUsers.reloadData()
        self.TVAddedUsers.reloadData()
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
        //    print("added")
        }
        else{
          //  print("removing")
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
